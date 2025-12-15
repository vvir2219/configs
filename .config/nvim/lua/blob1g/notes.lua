local function strip_ansi(s)
  return s:gsub("\27%[[0-9;]*m", "")
end

local function list_notebooks()
  local output = vim.fn.systemlist({ "notes", "list" })
  return output
end

vim.api.nvim_create_user_command(
  "NoteEdit",
  function(opts)
    local args = vim.split(opts.args, "%s+") -- split by spaces
    if #args ~= 1 or #args[1] == 0 then
      vim.notify("NoteEdit <notebook>", vim.log.levels.ERROR)
      return
    end

    local result = vim.fn.system({ "notes", "path", args[1] })
    local code = vim.v.shell_error -- exit code of the last system() call

    if code ~= 0 then
      local error = result:match("([^\r\n]+)")
      vim.notify(strip_ansi(error), vim.log.levels.ERROR)
      return
    end

    local path = result:gsub("^%s+", ""):gsub("%s+$", "")

    print(unpack(list_notebooks()))
    vim.cmd.edit(path)
  end,
  {
    desc = "Edit your notes",
    nargs = "*",
    complete = function(ArgLead, CmdLine, CursorPos)
      -- ArgLead: current word being completed
      local notebooks = list_notebooks()
      local matches = {}
      for _, name in ipairs(notebooks) do
        if name:match("^" .. vim.pesc(ArgLead)) then
          table.insert(matches, name)
        end
      end
      return matches
    end,
  }
)
