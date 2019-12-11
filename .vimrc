" Welcome to Vim (http://go/vim).
"
" If you see this file, your homedir was just created on this workstation.
" That means either you are new to Google (in that case, welcome!) or you
" got yourself a faster machine.
" Either way, the main goal of this configuration is to help you be more
" productive; if you have ideas, praise or complaints, direct them to
" vi-users@google.com (http://g/vi-users). We'd especially like to hear from you
" if you can think of ways to make this configuration better for the next
" Noogler.
" If you want to learn more about Vim at Google, see http://go/vimintro.

" Enable modern Vim features not compatible with Vi spec.
set nocompatible

" Google specific configuration
if filereadable("/usr/share/vim/google/google.vim")
  " Use the 'google' package by default (see http://go/vim/packages).
  source /usr/share/vim/google/google.vim

  " Automatic imports for Java
  Glug google-csimporter

  " Plugin configuration.
  " See http://google3/devtools/editors/vim/examples/ for example configurations
  " and http://go/vim/plugins for more information about vim plugins at Google.

  " Plugin loading is commented out below - uncomment the plugins you'd like to
  " load.

  " Load google's formatting plugins (http://go/vim/plugins/codefmt-google).
  " The default mapping is \= (or <leader>= if g:mapleader has a custom value),
  " with
  " - \== formatting the current line or selected lines in visual mode
  "   (:FormatLines).
  " - \=b formatting the full buffer (:FormatCode).
  "
  " To bind :FormatLines to the same key in insert and normal mode, add:
  "   noremap <C-K> :FormatLines<CR>
  "   inoremap <C-K> <C-O>:FormatLines<CR>
  "Glug codefmt plugin[mappings] gofmt_executable="goimports"
  Glug codefmt
  Glug codefmt-google

  " Enable autoformatting on save for the languages at Google that enforce
  " formatting, and for which all checked-in code is already conforming (thus,
  " autoformatting will never change unrelated lines in a file).
  " Note formatting changed lines only isn't supported yet
  " (see https://github.com/google/vim-codefmt/issues/9).
  augroup autoformat_settings
    autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType markdown AutoFormatBuffer mdformat
    autocmd FileType proto AutoFormatBuffer protofmt
    autocmd FileType python AutoFormatBuffer pyformat
    autocmd FileType textpb AutoFormatBuffer text-proto-format
  "  autocmd FileType go AutoFormatBuffer gofmt
  "  See go/vim/plugins/codefmt-google, :help codefmt-google and :help codefmt
  "  for details about other available formatters.
  augroup END

  " Load YCM (http://go/ycm) for semantic auto-completion and quick syntax
  " error checking. Pulls in a google3-enabled version of YCM itself and
  " a google3-specific default configuration.
  "Glug youcompleteme-google
  " I don't care about c and cpp completion
  "let g:ycm_filetype_blacklist = {'cpp': 1, 'c': 1}

  " Load the automated blaze dependency integration for Go.
  " Note: for Go, blazedeps uses the Go team's glaze tool, which is fully
  " supported by the Go team. The plugin is currently unsupported for other
  " languages.
  "Glug blazedeps auto_filetypes=`['go']`
  Glug blazedeps plugin[mappings]

  " Load piper integration (http://go/VimPerforce).
  "Glug piper plugin[mappings]

  " Load Critique integration. Use :h critique for more details.
  "Glug critique plugin[mappings]

  " Load blaze integration (http://go/blazevim).
  Glug blaze plugin[mappings]

  " Load the syntastic plugin (http://go/vim/plugins/syntastic-google).
  " Note: this requires installing the upstream syntastic plugin from
  " https://github.com/vim-syntastic/syntastic.
  "Glug syntastic-google

  " Load the ultisnips plugin (http://go/ultisnips).
  " Note: this requires installing the upstream ultisnips plugin from
  " https://github.com/SirVer/ultisnips.
  "Glug ultisnips-google
endif

" Vundle config start
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'https://github.com/kana/vim-textobj-user'
Plugin 'https://github.com/kana/vim-textobj-entire'
Plugin 'https://github.com/kana/vim-textobj-line'

" All of your Plugins must be added before the following line
call vundle#end()
" Vundle config end

" All of your plugins must be added before the following line.
" See go/vim-plugin-manager if you need help picking a plugin manager and
" setting it up.

" Enable file type based indent configuration and syntax highlighting.
" Note that when code is pasted via the terminal, vim by default does not detect
" that the code is pasted (as opposed to when using vim's paste mappings), which
" leads to incorrect indentation when indent mode is on.
" To work around this, use ":set paste" / ":set nopaste" to toggle paste mode.
" You can also use a plugin to:
" - enter insert mode with paste (https://github.com/tpope/vim-unimpaired)
" - auto-detect pasting (https://github.com/ConradIrwin/vim-bracketed-paste)

filetype plugin indent on
syntax on

set tabstop=2 shiftwidth=2 expandtab
set ruler
set nu
set nowrap
set colorcolumn=101
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
set relativenumber

" open terminal above the current one the current needs to be in visual modus
" (Ctrl+w+N)
map <leader>t :terminal<CR><C-w>j<Esc>i<Esc><C-w>k

let g:airline_theme='solarized'
