local t = require("nvim-treesitter.ts_utils")

local function print_node(label, node, with_range)
  if with_range == nil then
    with_range = true
  end

  if not node then
    print(label, "missing node")
    return
  end

  local row, col, row_end, col_end = node:range()
  local type = node:type()
  if with_range then
    print(label .. type, row + 1, col, row_end + 1, col_end)
  else
    print(label .. type)
  end
end

local function pos_compare(pos1, pos2)
  if not pos1 or not pos2 then return end

  local line_compare = pos1[1] - pos2[1]
  if line_compare ~= 0 then
    return line_compare
  end

  return pos1[2] - pos2[2]
end

local function cursor_pos()
  local c = vim.api.nvim_win_get_cursor(0)
  return { c[1], c[2] }
end

local function node_start(node)
  if not node then return end

  local row, col, _, _ = node:range()
  return { row + 1, col }
end

local function node_end(node)
  if not node then return end

  local _, _, row, col = node:range()
  return { row + 1, col }
end

local function node_next(node)
  if not node then return end
  return t.get_next_node(node, false, false)
end

local function node_previous(node)
  if not node then return end
  return t.get_previous_node(node, false, false)
end

local function node_parent(node)
  if not node then return end
  return node:parent()
end

local function highest_node_at_cursor(pos)
  local cursor = cursor_pos()
  local node = t.get_node_at_cursor(0)
  local parent = node_parent(node)

  while parent and node_parent(parent) and pos_compare(pos(parent), cursor) == 0 do
    node = parent
    parent = node_parent(parent)
  end

  return node
end

local function first_non_ovelaping_child(node)
  if not node then return end

  local children = t.get_named_children(node)
  for _, child in ipairs(children) do
    if pos_compare(node_start(node), node_start(child)) ~= 0 then
      return child
    end
  end
end

local function pos_is_after(pos1, pos2)
  if not pos1 or not pos2 then return end
  return pos_compare(pos1, pos2) > 0
end

local function pos_is_before(pos1, pos2)
  if not pos1 or not pos2 then return end
  return pos_compare(pos1, pos2) < 0
end

local function nodes_overlap(node1, node2)

end


local function cursor_prev_pos()
  local node = highest_node_at_cursor(node_start)
  if not node then return end
  print_node("Node at cursor: ", node)

  local next_node = node_previous(node)
  if next_node then
    print_node("Next node: ", next_node)
    return node_start(next_node)
  else
    print("going to the start of node")
    return node_start(node)
  end
end

local function cursor_next_pos()
  local current_node = t.get_node_at_cursor(0)
  local node = highest_node_at_cursor(node_start)
  if node == current_node then
    node = highest_node_at_cursor(node_end)
  end

  if not node then return end
  print_node("Node at cursor: ", node)

  local next_node = node_next(node)
  if next_node then
    print_node("Next node: ", next_node)
    return node_start(next_node)
  else
    return node_end(node)
  end
end

local function set_pos(get_pos)
  return function()
    local pos = get_pos()
    if not pos then return end

    vim.api.nvim_win_set_cursor(0, pos)
  end
end

vim.keymap.set({ "o", "n" }, "(", set_pos(cursor_prev_pos))
vim.keymap.set({ "o", "n" }, ")", set_pos(cursor_next_pos))

vim.keymap.set("o", "<c-w>", function()
  local next_node = getNextNode()
  if not next_node then return end

  local row, col, _, _ = next_node:range()
  print("Next node pos: ", row, col)

  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end)

local function print_node_and_children(prefix, node)
  print_node(prefix, node)

  local children = t.get_named_children(node)
  for _, child in ipairs(children) do
    print_node_and_children(" |" .. prefix, child)
  end
end

vim.keymap.set('n', 'g*', function()
  local cursor = cursor_pos()
  print("Cursor: ", cursor[1], cursor[2])

  local node = t.get_node_at_cursor(0)
  while node and pos_compare(cursor, node_start(node_parent(node))) == 0 do
    node = node_parent(node)
  end

  print_node_and_children("", node)
end)
