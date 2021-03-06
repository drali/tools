# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    export PS1="\[\033[01;32m\]\h:\w\[\033[34m\]\$(parse_git_branch)\[\033[00m\]\n$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias gsu='git submodule update --recursive --init'
alias gs='git status'
alias gb='git branch'

export EDITOR=vim
export BASH_SILENCE_DEPRECATION_WARNING=1

if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls="gls --color"
fi

# There be dragons beyond here. This is a large LS_COLORS palette generated by vivid:
#     (https://github.com/sharkdp/vivid)
# This particular color scheme is called snazzy
export LS_COLORS="ow=1;34:tw=1;34:mi=0;38;2;0;0;0;48;2;255;92;87:fi=0:or=0;38;2;0;0;0;48;2;255;92;87:*~=0;38;2;102;102;102:ex=1;38;2;255;92;87:pi=0;38;2;0;0;0;48;2;87;199;255:di=0;38;2;87;199;255:ln=0;38;2;255;106;193:so=0;38;2;0;0;0;48;2;255;106;193:no=0:*.a=1;38;2;255;92;87:*.z=4;38;2;154;237;254:*.p=0;38;2;90;247;142:*.r=0;38;2;90;247;142:*.d=0;38;2;90;247;142:*.o=0;38;2;102;102;102:*.t=0;38;2;90;247;142:*.m=0;38;2;90;247;142:*.c=0;38;2;90;247;142:*.h=0;38;2;90;247;142:*.7z=4;38;2;154;237;254:*.hi=0;38;2;102;102;102:*.nb=0;38;2;90;247;142:*.go=0;38;2;90;247;142:*.rs=0;38;2;90;247;142:*.ts=0;38;2;90;247;142:*.xz=4;38;2;154;237;254:*.pp=0;38;2;90;247;142:*.ml=0;38;2;90;247;142:*.di=0;38;2;90;247;142:*.ui=0;38;2;243;249;157:*.ps=0;38;2;255;92;87:*.hs=0;38;2;90;247;142:*.gv=0;38;2;90;247;142:*.sh=0;38;2;90;247;142:*.jl=0;38;2;90;247;142:*.bz=4;38;2;154;237;254:*.as=0;38;2;90;247;142:*.cr=0;38;2;90;247;142:*.rm=0;38;2;255;180;223:*.fs=0;38;2;90;247;142:*.el=0;38;2;90;247;142:*.rb=0;38;2;90;247;142:*.lo=0;38;2;102;102;102:*.cp=0;38;2;90;247;142:*.cc=0;38;2;90;247;142:*.ko=1;38;2;255;92;87:*.py=0;38;2;90;247;142:*.la=0;38;2;102;102;102:*.md=0;38;2;243;249;157:*.pl=0;38;2;90;247;142:*.mn=0;38;2;90;247;142:*.js=0;38;2;90;247;142:*.kt=0;38;2;90;247;142:*.hh=0;38;2;90;247;142:*.ex=0;38;2;90;247;142:*.so=1;38;2;255;92;87:*css=0;38;2;90;247;142:*.pm=0;38;2;90;247;142:*.gz=4;38;2;154;237;254:*.cs=0;38;2;90;247;142:*.vb=0;38;2;90;247;142:*.pps=0;38;2;255;92;87:*.tgz=4;38;2;154;237;254:*.log=0;38;2;102;102;102:*.arj=4;38;2;154;237;254:*.ico=0;38;2;255;180;223:*.hpp=0;38;2;90;247;142:*.wav=0;38;2;255;180;223:*.zip=4;38;2;154;237;254:*.jar=4;38;2;154;237;254:*.tbz=4;38;2;154;237;254:*.mid=0;38;2;255;180;223:*.dox=0;38;2;165;255;195:*.pas=0;38;2;90;247;142:*.ind=0;38;2;102;102;102:*.xcf=0;38;2;255;180;223:*.m4v=0;38;2;255;180;223:*.fon=0;38;2;255;180;223:*.pdf=0;38;2;255;92;87:*.flv=0;38;2;255;180;223:*.wma=0;38;2;255;180;223:*.dpr=0;38;2;90;247;142:*.bag=4;38;2;154;237;254:*.swp=0;38;2;102;102;102:*.dll=1;38;2;255;92;87:*.jpg=0;38;2;255;180;223:*.rpm=4;38;2;154;237;254:*.zsh=0;38;2;90;247;142:*.vcd=4;38;2;154;237;254:*.yml=0;38;2;243;249;157:*.xmp=0;38;2;243;249;157:*.tar=4;38;2;154;237;254:*.tml=0;38;2;243;249;157:*.ppt=0;38;2;255;92;87:*.fnt=0;38;2;255;180;223:*.xml=0;38;2;243;249;157:*.xls=0;38;2;255;92;87:*.fsx=0;38;2;90;247;142:*.sxi=0;38;2;255;92;87:*.pyc=0;38;2;102;102;102:*.vob=0;38;2;255;180;223:*.odp=0;38;2;255;92;87:*.nix=0;38;2;243;249;157:*.fls=0;38;2;102;102;102:*.pro=0;38;2;165;255;195:*.gvy=0;38;2;90;247;142:*.sxw=0;38;2;255;92;87:*.svg=0;38;2;255;180;223:*.csv=0;38;2;243;249;157:*.mli=0;38;2;90;247;142:*.ics=0;38;2;255;92;87:*.cxx=0;38;2;90;247;142:*.mov=0;38;2;255;180;223:*.blg=0;38;2;102;102;102:*.dot=0;38;2;90;247;142:*.tmp=0;38;2;102;102;102:*.csx=0;38;2;90;247;142:*.inl=0;38;2;90;247;142:*.txt=0;38;2;243;249;157:*.git=0;38;2;102;102;102:*.cpp=0;38;2;90;247;142:*.aux=0;38;2;102;102;102:*.tcl=0;38;2;90;247;142:*.clj=0;38;2;90;247;142:*.pgm=0;38;2;255;180;223:*.bcf=0;38;2;102;102;102:*.sbt=0;38;2;90;247;142:*.pid=0;38;2;102;102;102:*.sty=0;38;2;102;102;102:*.bak=0;38;2;102;102;102:*.otf=0;38;2;255;180;223:*.img=4;38;2;154;237;254:*.cfg=0;38;2;243;249;157:*.deb=4;38;2;154;237;254:*.bst=0;38;2;243;249;157:*.lua=0;38;2;90;247;142:*.odt=0;38;2;255;92;87:*hgrc=0;38;2;165;255;195:*.avi=0;38;2;255;180;223:*.ilg=0;38;2;102;102;102:*.gif=0;38;2;255;180;223:*.pod=0;38;2;90;247;142:*.ods=0;38;2;255;92;87:*.rst=0;38;2;243;249;157:*.vim=0;38;2;90;247;142:*.fsi=0;38;2;90;247;142:*.out=0;38;2;102;102;102:*.erl=0;38;2;90;247;142:*.swf=0;38;2;255;180;223:*.mpg=0;38;2;255;180;223:*.bat=1;38;2;255;92;87:*.bib=0;38;2;243;249;157:*.elm=0;38;2;90;247;142:*.tex=0;38;2;90;247;142:*.rar=4;38;2;154;237;254:*.ps1=0;38;2;90;247;142:*.sql=0;38;2;90;247;142:*.asa=0;38;2;90;247;142:*.epp=0;38;2;90;247;142:*.doc=0;38;2;255;92;87:*.awk=0;38;2;90;247;142:*.png=0;38;2;255;180;223:*.tsx=0;38;2;90;247;142:*.exe=1;38;2;255;92;87:*.c++=0;38;2;90;247;142:*TODO=1:*.bmp=0;38;2;255;180;223:*.pkg=4;38;2;154;237;254:*.toc=0;38;2;102;102;102:*.wmv=0;38;2;255;180;223:*.h++=0;38;2;90;247;142:*.bsh=0;38;2;90;247;142:*.cgi=0;38;2;90;247;142:*.idx=0;38;2;102;102;102:*.iso=4;38;2;154;237;254:*.ogg=0;38;2;255;180;223:*.bz2=4;38;2;154;237;254:*.exs=0;38;2;90;247;142:*.pbm=0;38;2;255;180;223:*.mp3=0;38;2;255;180;223:*.mp4=0;38;2;255;180;223:*.xlr=0;38;2;255;92;87:*.php=0;38;2;90;247;142:*.ini=0;38;2;243;249;157:*.ipp=0;38;2;90;247;142:*.bbl=0;38;2;102;102;102:*.bin=4;38;2;154;237;254:*.aif=0;38;2;255;180;223:*.ppm=0;38;2;255;180;223:*.htc=0;38;2;90;247;142:*.apk=4;38;2;154;237;254:*.mkv=0;38;2;255;180;223:*.rtf=0;38;2;255;92;87:*.com=1;38;2;255;92;87:*.kts=0;38;2;90;247;142:*.dmg=4;38;2;154;237;254:*.ltx=0;38;2;90;247;142:*.ttf=0;38;2;255;180;223:*.kex=0;38;2;255;92;87:*.tif=0;38;2;255;180;223:*.htm=0;38;2;243;249;157:*.hxx=0;38;2;90;247;142:*.epub=0;38;2;255;92;87:*.purs=0;38;2;90;247;142:*.html=0;38;2;243;249;157:*.make=0;38;2;165;255;195:*.yaml=0;38;2;243;249;157:*.flac=0;38;2;255;180;223:*.psd1=0;38;2;90;247;142:*.fish=0;38;2;90;247;142:*.orig=0;38;2;102;102;102:*.less=0;38;2;90;247;142:*.json=0;38;2;243;249;157:*.toml=0;38;2;243;249;157:*.lock=0;38;2;102;102;102:*.tbz2=4;38;2;154;237;254:*.lisp=0;38;2;90;247;142:*.docx=0;38;2;255;92;87:*.mpeg=0;38;2;255;180;223:*.bash=0;38;2;90;247;142:*.pptx=0;38;2;255;92;87:*.jpeg=0;38;2;255;180;223:*.conf=0;38;2;243;249;157:*.hgrc=0;38;2;165;255;195:*.psm1=0;38;2;90;247;142:*.h264=0;38;2;255;180;223:*.rlib=0;38;2;102;102;102:*.xlsx=0;38;2;255;92;87:*.java=0;38;2;90;247;142:*.dart=0;38;2;90;247;142:*.diff=0;38;2;90;247;142:*.xhtml=0;38;2;243;249;157:*.swift=0;38;2;90;247;142:*passwd=0;38;2;243;249;157:*shadow=0;38;2;243;249;157:*.scala=0;38;2;90;247;142:*.toast=4;38;2;154;237;254:*.class=0;38;2;102;102;102:*.ipynb=0;38;2;90;247;142:*.cabal=0;38;2;90;247;142:*.patch=0;38;2;90;247;142:*.shtml=0;38;2;243;249;157:*README=0;38;2;40;42;54;48;2;243;249;157:*.cache=0;38;2;102;102;102:*.mdown=0;38;2;243;249;157:*.dyn_o=0;38;2;102;102;102:*.cmake=0;38;2;165;255;195:*.matlab=0;38;2;90;247;142:*INSTALL=0;38;2;40;42;54;48;2;243;249;157:*.dyn_hi=0;38;2;102;102;102:*.ignore=0;38;2;165;255;195:*.flake8=0;38;2;165;255;195:*.gradle=0;38;2;90;247;142:*.config=0;38;2;243;249;157:*TODO.md=1:*LICENSE=0;38;2;153;153;153:*COPYING=0;38;2;153;153;153:*.groovy=0;38;2;90;247;142:*Makefile=0;38;2;165;255;195:*Doxyfile=0;38;2;165;255;195:*.desktop=0;38;2;243;249;157:*.gemspec=0;38;2;165;255;195:*TODO.txt=1:*setup.py=0;38;2;165;255;195:*.rgignore=0;38;2;165;255;195:*.fdignore=0;38;2;165;255;195:*.cmake.in=0;38;2;165;255;195:*.markdown=0;38;2;243;249;157:*.kdevelop=0;38;2;165;255;195:*README.md=0;38;2;40;42;54;48;2;243;249;157:*configure=0;38;2;165;255;195:*COPYRIGHT=0;38;2;153;153;153:*.gitignore=0;38;2;165;255;195:*INSTALL.md=0;38;2;40;42;54;48;2;243;249;157:*.scons_opt=0;38;2;102;102;102:*README.txt=0;38;2;40;42;54;48;2;243;249;157:*CODEOWNERS=0;38;2;165;255;195:*Dockerfile=0;38;2;243;249;157:*SConstruct=0;38;2;165;255;195:*SConscript=0;38;2;165;255;195:*.gitconfig=0;38;2;165;255;195:*.synctex.gz=0;38;2;102;102;102:*MANIFEST.in=0;38;2;165;255;195:*Makefile.in=0;38;2;102;102;102:*.gitmodules=0;38;2;165;255;195:*.travis.yml=0;38;2;90;247;142:*Makefile.am=0;38;2;165;255;195:*LICENSE-MIT=0;38;2;153;153;153:*.fdb_latexmk=0;38;2;102;102;102:*CONTRIBUTORS=0;38;2;40;42;54;48;2;243;249;157:*.applescript=0;38;2;90;247;142:*appveyor.yml=0;38;2;90;247;142:*configure.ac=0;38;2;165;255;195:*.clang-format=0;38;2;165;255;195:*CMakeCache.txt=0;38;2;102;102;102:*CMakeLists.txt=0;38;2;165;255;195:*.gitattributes=0;38;2;165;255;195:*LICENSE-APACHE=0;38;2;153;153;153:*INSTALL.md.txt=0;38;2;40;42;54;48;2;243;249;157:*CONTRIBUTORS.md=0;38;2;40;42;54;48;2;243;249;157:*CONTRIBUTORS.txt=0;38;2;40;42;54;48;2;243;249;157:*requirements.txt=0;38;2;165;255;195:*.sconsign.dblite=0;38;2;102;102;102:*package-lock.json=0;38;2;102;102;102"
