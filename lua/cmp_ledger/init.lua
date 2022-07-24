local has_cmp, cmp = pcall(require, 'cmp')
if not has_cmp then
  return
end

local has_job, Job = pcall(require, 'plenary.job')
if not has_job then
  return
end

local source = {}

source.new = function()
  local self = setmetatable({}, { __index = source })
  return self
end

source.get_trigger_characters = function()
  return {
    'Ex',
    'In',
    'As',
    'Li',
    'Eq',
    'E:',
    'I:',
    'A:',
    'L:',
  }
end

source.complete = function(_, _, callback)
  local current_buf_name = vim.api.nvim_buf_get_name(0)

  Job:new({
    command = 'ledger',
    args = { '-f', current_buf_name, 'accounts' },
    on_exit = function(job)
      local result = job:result()

      local items = {}
      for _, item in ipairs(result) do
        table.insert(items, {
          label = item,
          kind = cmp.lsp.CompletionItemKind.Property,
        })
      end

      callback { items = items, isIncomplete = false }
    end,
  }):start()
end

source.is_available = function()
  return vim.bo.filetype == 'ledger'
end

return source
