# Bertabus customizations
DISABLE_AUTO_UPDATE="true"
setopt DVORAK
export PRINTER=HP_LaserJet_CP1525nw
export TERM=xterm-256color #important for ssh compatibility
export EDITOR=vim
export HISTFILE=$XDG_CONFIG_HOME/.zsh_history
export BROWSER=chromium
export wiki_browser=$BROWSER

# Set vimrc's location and source it on vim startup
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export XDG_CONFIG_HOME=~/.config
export LC_ALL=""
export LC_COLLATE=C
export LANG=en_US.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.config/oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="aussiegeek"

if [[ -z "$SSH_CLIENT" ]]; then
        prompt_host=""
else
        prompt_host=%{$fg_bold[white]%}@%{$reset_color$fg[yellow]%}$(hostname -s)
fi

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="yyyy-mm-dd"

# LATEX command to compile with ps-tricks, will likely cause problems for you
alias pdflatex="pdflatex --shell-escape"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(archlinux git git-extras github pip python debian \
	colored-man fasd nyan vundle lol django extract \
	golang systemd )
#requires installation of fasd, 

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases for Kirsten to be able to print from keypad hooked up

alias 01='scanimage --mode Binary --resolution 600 -x 215.9 -y 279.4 > test.ppm'
alias 01='scanimage --mode Binary --resolution 600 > test.ppm'
alias 01='scanimage --mode Binary --resolution 600 > test.ppm'

# A few customization aliases 
alias :q=exit
alias o=xdg-open
alias www=$BROWSER %U
# alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias lr='ls -atr'
alias lla='ls -al'
alias lF='ls -F'
alias laF='ls -laF'
alias llF='ls -lF'
alias llaF='ls -alF'
alias j="z" #fasd alias for file jumping 
alias less='most'
alias get-groups='cut -d: -f1 /etc/group'
# Rename or move multiple files the easy way
# http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
autoload -U zmv           # activate zmv command
alias mmv='noglob zmv -W' # set the zmv command alias to mmv

# I almost always want to preserve environment so make it default
alias sudo='sudo -E'

# for custom programs/installations
# All programs should be placed in /opt/
export PATH=$HOME/.config/bin:/usr/local/bin:$PATH
export PATH=~/.cabal/bin:$PATH
export GOPATH=~/go
export GOBIN=~/go/bin
export PATH=$PATH:~/go/bin
export PATH=/opt/saleae:$PATH
export PATH=/opt/altera/13.1/quartus/bin:$PATH
export PATH=/usr/local/texlive/2013/bin/x86_64-linux/:$PATH
alias saleae=logic
alias quartus='quartus --64bit'
alias 'pypy.test'='/opt/pypy/bin/py.test'
alias 'pypy.install'='sudo /opt/pypy/bin/easy_install'
alias 'screen'='screen -c ~/.config/screenrc'

function img {
last=${(P)#}
if [ -f $last ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $last in
                *.gif)          gifview -a "$@";;
                *)              feh "$@"    ;;
        esac
# else
#         echo "$1 - file does not exist"
fi

}


# for android setup
export LD_LIBRARY_PATH=/opt/google/Android-Sdk/sdk/tools/lib:$LD_LIBRARY_PAT
# android is general tool
alias 'android'='/opt/google/Android-Sdk/sdk/tools/android'
# use emu_android Lolipop_x86_avd_name
emu_android () {/opt/google/Android-Sdk/sdk/tools/emulator-x86 \
        -avd "$@" -gpu on -qemu -m 1024 -enable-kvm}

# for google cloud 
# The next line updates PATH for the Google Cloud SDK.
source '/opt/google/google-cloud-sdk/path.zsh.inc'
# The next line enables bash completion for gcloud.
source '/opt/google/google-cloud-sdk/completion.zsh.inc'
# the next line sets the correct python for the sdk
export CLOUDSDK_PYTHON="python2" 
# export PATH=$PATH:/opt/google/
# golang is in flux, gcloud is buggy so alias goapp
alias godeploy="/opt/google/go_appengine/goapp deploy -oauth"
# alias goserve="gcloud preview app run"
# alias goserve="gcloud preview app run app.yaml"
# alias goserve="/opt/google/go_appengine/appcfg.py serve"
# alias goserve="/opt/google/google-cloud-sdk/platform/google_appengine/dev_appserver.py"
alias goserve="python2 /opt/google/go_appengine/dev_appserver.py \`pwd\`/app.yaml"
alias goapp="/opt/google/go_appengine/goapp"
# make context and vim-go recognize app-engine libs
# alias appvim="export GOROOT=$APPENGINE_SDK/goroot && vim"

# add dvd and cd burning aliases
# use these as burn[cd/dvd] /dev/sr0 file1 file2 file3
# burndvd may need export MKISOFS="genisoimage"
burndvd () {growisofs -Z $1 -V "ARCHIVE_2013_07_27" -r -J ${*:2}}
alias burnblu=burndvd
burncd () {genisoimage -V "ARCHIVE_2013_07_27" -J -r ${*:2} | \
wodim -v dev=$1 -waiti -}

export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="/usr/local/texlive/2013/texmf-dist/doc/man"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
#

# random fortune cookie on terminal load, but only a short one
fortune -s

# startx if not started already
# only run if not running headless
# to get graphics run `touch ~/graphics`
if [[ -e ~/graphics ]]
then
  [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx ~/.config/X11/xinitrc #;\
   # feh --randomize --bg-fill ~/Pictures/wallpapers/
fi

## add the following text to enable autologin for prior command
#/etc/systemd/system/getty@tty1.service.d/autologin.conf
#[Service]
#ExecStart=
#ExecStart=-/usr/bin/agetty --autologin username --noclear %I 38400 linux


