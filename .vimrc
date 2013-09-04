" Fire up pathogen
call pathogen#infect()

" Initial, basic set-up
set nocompatible
set laststatus=2
set encoding=utf-8
set t_Co=256
set smartindent
set textwidth=80
set shiftwidth=4
set expandtab
set hlsearch
set hidden
set modelines=1
set tabstop=4
set nonumber 
set notimeout
set ttimeout
set timeoutlen=10
syntax enable
filetype plugin on
filetype indent on

" Customize search
set incsearch

" Setup persistent undo (poor-mans version control)
set undofile

" Make the backspace key work all the time, not just after insert
set backspace+=indent,eol,start

" Powerline plugin-configuration
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'solarized256'

" Abbreviations
ab acr Adam C. Riggall
ab brp Bradley R. Postle

""""
" Custom mappings
""""
" Execute current file
"map \e :!%:p<C-m>
" Toggle line numbers and fold column for easy copying:
"nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
" View PDF in Skim
"map \v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf %<CR><C-L>
"map \sv :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf %<CR><C-L>

" Format paragraph
map <leader>p mx{<CR>!}fmt -79<CR>'x
"
" Run current python script
"map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
"map <C-m> :call Send_to_Tmux("make\n")<CR>

" Gundo setup
nnoremap <leader>u :GundoToggle<CR>

" Customize syntax higlighting colors

" Fix Sweave coloring so that code block headers are in Blue
"hi def link rnowebDelimiter Include

" vim-r-plugin settings
let vimrplugin_applescript = 0
let vimrplugin_notmuxconf = 1
let vimrplugin_vimpager = "horizontal"
"let g:vimrplugin_term_cmd = "term"
"let vimrplugin_screenplugin = 1
"let vimrplugin_underscore = 0
"let vimrplugin_screenvsplit = 0
"let r_syntax_folding = 1
"let ScreenShellGnuScreenVerticalSupport = 1
"let ScreenShellGnuScreenVerticalSupport = 'native'
"let showmarks_enable = 0
"let g:SuperTabMappingTabLiteral = '\<tab>'
"autocmd FileType r setlocal formatoptions=cq

"if $TERM=='screen'
"   exe "set title titlestring=vim:%f"
"   exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
"endif

"let g:ScreenImpl = 'Tmux'
"let g:ScreenShellHeight = 20

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
"
" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>P :set paste<CR>:put  *<CR>:set nopaste<CR>

"hi Comment ctermfg=Green 
"hi String ctermfg=Red
"hi Delimiter ctermfg=White
"hi Statement ctermfg=Yellow
"hi Identifier ctermfg=White
"hi Function ctermfg=Cyan
"highlight ShowMarksHLl ctermfg=Green ctermbg=Black
"highlight ShowMarksHLu ctermfg=Cyan ctermbg=Black
"highlight ShowMarksHLo ctermfg=Yellow ctermbg=Black
"highlight ShowMarksHLm ctermfg=Blue ctermbg=Black
"highlight SignColumn ctermfg=Red ctermbg=Black
"highlight LineNr ctermfg=DarkGray
"highlight Todo ctermfg=Black ctermbg=Red
"highlight SpellBad      ctermfg=Red         term=Underline     ctermbg=Black
"highlight SpellCap      ctermfg=Green       term=Underline     ctermbg=Black
"highlight SpellLocal    ctermfg=Cyan        term=Underline     ctermbg=Black
"highlight SpellRare     ctermfg=Magenta     term=underline     ctermbg=Black
"
" Setup vim-colors-solarized
set background=dark
colorscheme solarized

" No weak encryption!
set cryptmethod=blowfish
