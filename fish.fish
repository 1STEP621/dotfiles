if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g theme_display_date yes
    set -g theme_date_format "+%F %H:%M"
    set -g fish_greeting

    export PATH="$HOME/.local/bin:$PATH"
    export LANG='ja_JP.UTF-8'

    export BAT_THEME="OneHalfDark"
    set -U FZF_FIND_FILE_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -U FZF_PREVIEW_FILE_CMD 'bat -p --color=always --style=grid --line-range=:500'
    set -U FZF_PREVIEW_DIR_CMD 'll'
    set -U FZF_FIND_FILE_OPTS "--preview '$FZF_PREVIEW_FILE_CMD'"

    alias c='clear'

    alias install='sudo apt install'
    alias remove='sudo apt remove'
    alias uninstall='remove'
    alias reinstall='sudo apt install --reinstall'
    alias update='sudo apt update'
    alias upgrade='sudo apt upgrade'
    alias autoremove='sudo apt autoremove'
    alias search='apt search'
    alias show='apt show'
    alias purge='sudo apt purge'

    alias ls='eza --git --hyperlink --icons --time-style="+%Y-%m-%d %H:%M"'
    alias ll='eza --git --hyperlink --icons --time-style="+%Y-%m-%d %H:%M" -ahl'
    alias lt='eza --git --hyperlink --icons --time-style="+%Y-%m-%d %H:%M" --tree'

    alias gcs='gh copilot suggest -t shell'
    alias gce='gh copilot explain'

    export RUST_BACKTRACE=1
    alias cc='cargo compete'
    alias cct='cargo compete test'
    alias ccs='cargo compete submit'
    function ccn
        cd ~/Programs/rust
        cargo compete new $argv && cd ~/Programs/rust/$argv && code .
    end
    alias rust='evcxr'

    function cubeide
        /opt/st/stm32cubeide_1.15.0/stm32cubeide 2> /dev/null & disown
    end

    alias webstorm='webstorm 2> /dev/null & disown'

    function toja
        echo -e "\e[1;36mPless Ctrl-D to finish.\e[0m"
        deepl --fr auto --to ja -s 2> /dev/null | tee /dev/tty | xclip -selection clipboard
    end
    function toen
        echo -e "\e[1;36mPless Ctrl-D to finish.\e[0m"
        deepl --fr auto --to en -s 2> /dev/null | tee /dev/tty | xclip -selection clipboard
    end
    
    function ff
        firefox $argv 2> /dev/null & disown
    end
    
    eval (functions cd)
    eval (zoxide init fish --cmd cd | source)
    eval (functions cd)
    eval (functions __zoxide_cd_internal)
end
