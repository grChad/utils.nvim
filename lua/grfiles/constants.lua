local M = {}

M.opts_scolumn = {
   -- stylua: ignore
   list_langs = {
      'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
    'lua', 'python', 'java', 'c', 'cpp', 'rust', 'go', 'sh', 'vim', 'bash', 'zsh',
    'fish', 'powershell', 'r', 'ruby', 'perl', 'php', 'sql', 'json', 'yaml',
    'markdown', 'ini', 'toml', 'properties', 'scss', 'less', 'sass', 'stylus',
    'xml', 'xhtml', 'xsl'
   },
   add_with_fold = {},
   without_fold = {},
   -- stylua: ignore
   disabled = {
      'alpha', 'dashboard', 'NvimTree',  'Outline', 'help', 'lspinfo', 'packer', 'qf',
      'startify', 'startuptime', 'vimfiler', 'vimhelp', 'viminfo', 'undotree', 'lazy',
      'mason', 'TelescopePrompt', 'Telescope', 'toggleterm', 'diff', 'fugitiveblame'
   },
}

return M
