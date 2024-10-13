local source = {}

function source.new()
  local itemKind = require('cmp').lsp.CompletionItemKind.Keyword
  source.types = {
    {label = 'feat', documentation = 'A new feature', kind = itemKind},
    {label = 'fix', documentation = 'A bug fix', kind = itemKind},
    {label = 'perf', documentation = 'A code change that improves performance', kind = itemKind},
    {label = 'refactor', documentation = 'A code change that doesnt change functionality', kind = itemKind},
    {label = 'test', documentation = 'Adding or changing tests', kind = itemKind},
    {label = 'style', documentation = 'Style changes on the code', kind = itemKind},
    {label = 'revert', documentation = 'Undo a previous commit', kind = itemKind},
    {label = 'enh', documentation = 'Code improvemente that doesnt add new feaures or fixes bug', kind = itemKind},
    {label = 'doc', documentation = 'Update documentation', kind = itemKind},
    {label = 'chore', documentation = 'Repetitive common tasks', kind = itemKind},
    {label = 'audit', documentation = 'Code audit and diagnostics', kind = itemKind}
  }

  return setmetatable({}, {__index = source})
end

function source:is_available() return vim.bo.filetype == "gitcommit" end

function source:get_keyword_pattern() return [[\w\+]] end

function source:complete(request, callback)
  if request.context.option.reason == "manual" and request.context.cursor.row == 1 and request.context.cursor.col <= 1 then
    callback({items = self.types, isIncomplete = true})
  elseif request.context.option.reason == "auto" and request.context.cursor.row == 1 and request.context.cursor.col <= 2 then
    callback({items = self.types, isIncomplete = true})
  elseif request.context.cursor.row > 2 and request.context.cursor.col <= 2 then
    callback({items = {{label = 'Tarea'}, {label = 'Task'}, {label = 'Issue'}}, isIncomplete = true})
  else
    callback()
  end
end

return source
