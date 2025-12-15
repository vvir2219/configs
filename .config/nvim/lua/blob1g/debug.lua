_G.redir_messages_to_buffer = false

local function redir_messages_to_buffer(buff, timeout)
  _G.redir_messages_to_buffer = true

  local function write_and_clear()
    if not vim.api.nvim_buf_is_valid(buff) then
      return
    end

    local messages = vim.split(vim.fn.execute("messages", "silent"), "\n")

    if #messages > 1 then
      local line_count = vim.api.nvim_buf_line_count(buff)
      vim.api.nvim_buf_set_lines(buff, line_count, line_count, false, messages)
      vim.cmd("messages clear")

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buff then
          vim.api.nvim_win_call(win, function()
            vim.api.nvim_win_set_cursor(win, { line_count + #messages, 0 })
          end)
        end
      end
    end

    if _G.redir_messages_to_buffer then
      vim.defer_fn(write_and_clear, timeout)
    end
  end

  vim.defer_fn(write_and_clear, timeout)
end

local function stop_redir()
  _G.redir_messages_to_buffer = false
end

vim.api.nvim_create_user_command("RedirMessagesToBuffer", function()
  local curr_buff = vim.api.nvim_get_current_buf()
  redir_messages_to_buffer(curr_buff, 200)
end, {})

vim.api.nvim_create_user_command("StopRedirMessages", stop_redir, {})
