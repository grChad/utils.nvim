vim.api.nvim_set_hl(0, 'FoldSignsOpen', { fg = '#EEFFFF', bg = '#292C3C' })
vim.api.nvim_set_hl(0, 'FoldSignsClosed', { fg = '#a5adce', bg = '#292C3C' })

local validateTable = require('grfiles.utils').validateTable
local combineTable = require('grfiles.utils').combineTable
local opts_default = require('grfiles.constants').opts_scolumn

local column_num = function(win)
   local is_num = vim.wo[win].number
   local is_relnum = vim.wo[win].relativenumber

   if is_num and is_relnum then
      return '%=%{v:relnum?(v:virtnum>0?"":v:relnum):(v:virtnum>0?"":v:lnum)} '
   elseif is_num and not is_relnum then
      return '%=%{v:virtnum>0?"":v:lnum} '
   elseif is_relnum and not is_num then
      return '%=%{v:virtnum>0?"":v:relnum} '
   else
      return ''
   end
end

local column_fold = function()
   if vim.fn.eval('foldlevel(v:lnum) > foldlevel(v:lnum - 1)') == 1 then
      if vim.fn.eval('foldclosed(v:lnum) == -1') == 1 then
         return '%#FoldSignsClosed# %T'
      elseif vim.fn.eval('foldclosed(v:lnum) != -1') == 1 then
         return '%#FoldSignsOpen# %T'
      end
   else
      return '  %T'
   end
end

local M = {}

M.withFold = function()
   local win = vim.g.statusline_winid

   return table.concat({
      '%s%=%T',
      column_num(win),
      column_fold(),
   })
end

M.withoutFold = function()
   local win = vim.g.statusline_winid
   return table.concat({
      '%s%=%T',
      column_num(win),
   })
end

---@class GrStatusColumn
---@field list_langs table<string>?
---@field add_with_fold table<string>?
---@field without_fold table<string>?
---@field disabled table<string>?

---@param userTable GrStatusColumn
function M.setup(userTable)
   userTable = userTable or {}

   local name_group = 'GrStatusColumn'
   vim.api.nvim_create_augroup(name_group, { clear = true })

   vim.api.nvim_create_autocmd('Filetype', {
      group = name_group,
      pattern = combineTable(userTable.add_with_fold, opts_default.list_langs),
      callback = function()
         vim.opt_local.statuscolumn = "%!v:lua.require('grfiles.modules.statuscolumn').withFold()"
      end,
   })

   local without_fold = userTable.without_fold
   if validateTable(without_fold) and #without_fold > 0 then
      vim.api.nvim_create_autocmd('Filetype', {
         group = name_group,
         pattern = without_fold,
         callback = function()
            vim.opt_local.statuscolumn = "%!v:lua.require('grfiles.modules.statuscolumn').withoutFold()"
         end,
      })
   end

   vim.api.nvim_create_autocmd('Filetype', {
      group = name_group,
      pattern = combineTable(userTable.disabled, opts_default.disabled),
      callback = function()
         vim.opt_local.relativenumber = false
         vim.opt_local.number = false
         vim.opt_local.signcolumn = 'no'
         vim.opt_local.colorcolumn = ''
      end,
   })
end

return M
