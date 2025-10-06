{ config, pkgs, ...}: {

programs.neovim = { 
enable = true;   
defaultEditor = true;
 extraConfig = ''
 set clipboard=unnamed
 set number
'';
plugins = with pkgs.vimPlugins; [ 
{
plugin =  nvim-tree-lua;
config = ''
packadd! nvim-tree.lua
''; }
# { 
#plugin = vim-vinegar;
#}
{
plugin = vim-suda;
 config = ''
let g:suda_smart_edit = 1
let g:suda#nopass = 1
'';
}
];
}; 
 }
 
