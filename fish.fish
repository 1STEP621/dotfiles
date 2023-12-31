if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g theme_display_date yes
    set -g theme_date_format "+%F %H:%M"
    set -g fish_greeting

    export PATH="$HOME/.local/bin:$PATH"
    export LANG='ja_JP.UTF-8'

    export BAT_THEME="OneHalfDark"
    set -U FZF_FIND_FILE_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -U FZF_PREVIEW_FILE_CMD 'bat --color=always --style=grid --line-range=:500'
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

    function mkpost
        set arg1 $argv[1]
        set arg2 $argv[2]
        curl -X POST -H "Content-Type: application/json" -d '{"i": "m3K0KZ8b7sqaFOphJBVuc18xER8a2Xcj", "text": "'$arg1'"}' https://$arg2/api/notes/create
    end

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

    eval (functions cd)
    eval (zoxide init fish --cmd cd | source)
    eval (functions cd)
    eval (functions __zoxide_cd_internal)
end