" Anirudh's Neovim Customizations

call plug#begin('~/.config/nvim/plugged')
" Linting
Plug 'neomake/neomake'
" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'arcticicestudio/nord-vim'
" Status Bar
Plug 'itchyny/lightline.vim'
" Standard of Living Toolbox
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/goyo.vim'
" LaTeX and Notetaking
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'matze/vim-tex-fold'
" Commenting
Plug 'scrooloose/nerdcommenter'
Plug 'yuttie/comfortable-motion.vim'
call plug#end()

" Basic Setup Configurations
set mouse=a
set relativenumber
colorscheme nord
imap jj <ESC>
set clipboard=unnamedplus

" These setting should be overwritten in language specific settings
set tabstop=4
set textwidth=80
set colorcolumn=80
set shiftwidth=4
" inoremap {<CR> {<CR>}<C-o>O
" Better Whitespace
nnoremap sw :StripWhitespace<CR>

" Lightline Customizations
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
set noshowmode
" Vimtex Customizations
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" UltiSnips Settings
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir="/Users/anican/UltiSnips/"
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/UltiSnips"]
" old directory: /Users/anican/UltiSnips/


" NeoMake Customizations
" call neomake#configure#automake('w')
