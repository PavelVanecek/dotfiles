#!/bin/bash

alias ll='ls -lh'
alias la='ls -lha'
alias noidle="pmset noidle"
alias nosleep=noidle
alias generate_password='openssl rand -base64 32'
alias murder-amp='sudo launchctl unload /Library/LaunchDaemons/com.sourcefire.amp.daemon.plist'
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:$HOME/.fastlane/bin/fastlane_lib:$PATH"
# https://twitter.com/liamosaur/status/506975850596536320
eval "$(thefuck --alias)"
. ~/.docker-completion.sh
export NODE_ENV=development
export EDITOR=vim
export ANDROID_HOME=~/android/android-sdk-macosx/
alias setJdk6='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias setJdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias setJdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
# setJdk8
alias shrug='printf "%s" "¯\_(ツ)_/¯" | pbcopy && echo "copied to clipboard ¯\_(ツ)_/¯"'
alias tableflip='printf "%s" "(╯°□°)╯︵ ┻━┻" | pbcopy && echo "copied to clipboard (╯°□°)╯︵ ┻━┻"'
alias gimme='printf "%s" "༼ つ ◕_◕ ༽つ" | pbcopy && echo "copied to clipboard ༼ つ ◕_◕ ༽つ"'

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

export CUDA_ROOT=/usr/local/cuda
export LIBRARY_PATH=$CUDA_ROOT/lib:$CUDA_ROOT/lib64:$LIBRARY_PATH
export LD_LIBRARY_PATH=$CUDA_ROOT/lib:$CUDA_ROOT/lib64:$LIBRARY_PATH
export DYLD_LIBRARY_PATH=$CUDA_ROOT/lib:$CUDA_ROOT/lib64:$LIBRARY_PATH

if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  . "$(brew --prefix)/etc/bash_completion"
fi
# . <(npm completion)

# Will change OSX Terminal color scheme everytime when using ssh
__colourful_ssh() {
  # https://github.com/koalaman/shellcheck/wiki/SC2155
  local OLD_PROFILE_NAME
  OLD_PROFILE_NAME=$(osascript -e 'tell application "Terminal" to get name of current settings of selected tab of window 1')
  local NEW_PROFILE_NAME='Red Sands'
  osascript -e "tell application \"Terminal\" to set current settings of selected tab of window 1 to (first settings set whose name is \"$NEW_PROFILE_NAME\")"
  ssh "$@"
  osascript -e "tell application \"Terminal\" to set current settings of selected tab of window 1 to (first settings set whose name is \"$OLD_PROFILE_NAME\")"
}
alias ssh=__colourful_ssh

export NVM_DIR="/Users/vanecekp/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
eval "$(fasd --init bash-hook posix-alias)"

# https://github.com/zeit/hyper/issues/284#issuecomment-247669308
function title() {
  echo -e "\033]0;${1:?please specify a title}\007";
}

function __prompt_command() {
    local EXIT="$?" # This needs to be first
    PS1=""

    local HOSTNAME # you might want to put '\h' instead
    local USERNAME='\u'

    local ResetColor='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    local White='\[\e[0;37m\]'

    if [ $EXIT != 0 ]; then
        # string padding
        printf -v HOSTNAME "% 3s" "$EXIT"
        PS1+="${Red}${USERNAME}${ResetColor}" # Add red if exit code non 0
    else
        HOSTNAME='mac'
        PS1+="${Gre}${USERNAME}${ResetColor}"
    fi

    function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo '*'
    }

    function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
    }

    PS1+="${ResetColor}@${White}${HOSTNAME} ${Pur}\W${White}$(parse_git_branch) ${BYel}$ ${ResetColor}"
}

# this needs to be last!!!1
PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs
