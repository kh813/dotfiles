# .bashrc : 2026/04/12

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# 共通設定の読み込み
if [ -f "${HOME}/.commonrc" ]; then
  source "${HOME}/.commonrc"
fi


# --- PROMPT ---
blue_p="\[\e[34m\]"
green_p="\[\e[32m\]"
reset_p="\[\e[0m\]"

if [ "${BASH_VERSINFO[0]}" -ge 4 ]; then
  # ===== Bash 4+: 右プロンプト + transient =====
  _RPROMPT_LEN=0

  _rprompt_erase() {
    [[ "${BASH_COMMAND}" == "_build_prompt" ]] && return
    (( _RPROMPT_LEN > 0 )) && \
      printf "\033[999C\033[%dD\033[K\r" "$_RPROMPT_LEN"
  }
  trap '_rprompt_erase' DEBUG

  _build_prompt() {
    local symbol="$"
    [[ $UID -eq 0 ]] && symbol="#"
    local cur_dir="${PWD/$HOME/\~}"
    local r_len=$(( ${#cur_dir} + 4 ))
    local col=$(( COLUMNS - r_len ))
    (( _RPROMPT_LEN > 0 )) && \
      printf "\033[%dG\033[K" $(( COLUMNS - _RPROMPT_LEN + 1 ))
    _RPROMPT_LEN=$r_len
    printf "\033[%dG[ \033[33m%s\033[0m ]\r" "$(( col + 1 ))" "$cur_dir"
    PS1="${blue_p}\u${reset_p}@${green_p}\h${reset_p} ${symbol} "
  }

  # \C-m → 未使用キー（\C-o）に付け替え
  # \C-o → _transient_enter（関数） → \C-o は元々 operate-and-get-next
  # という多段は複雑なので、シンプルに：
  _transient_enter() {
    (( _RPROMPT_LEN > 0 )) && \
      printf "\033[999C\033[%dD\033[K\r" "$_RPROMPT_LEN" > /dev/tty
  }
  # \C-m に「_transient_enter を実行してから accept-line」を設定
  bind -x '"\C-x\C-e": _transient_enter'   # 未使用キーに関数を割り当て
  bind '"\C-m": "\C-x\C-e\C-j"'            # Enter → 関数起動 → \C-j（accept-line）
  bind '"\C-j": accept-line'               # \C-j は素のaccept-line（再帰しない）

else
  # ===== Bash 3.x: 右プロンプトあり（transientなし）=====
  [[ "$(uname)" == "Darwin" ]] && export BASH_SILENCE_DEPRECATION_WARNING=1

  _build_prompt() {
    local symbol="$"
    [[ $UID -eq 0 ]] && symbol="#"
    local cur_dir="${PWD/$HOME/~}"
    local cols=${COLUMNS:-$(tput cols)}
    local r_len=$(( ${#cur_dir} + 4 ))
    local col=$(( cols - r_len ))
    printf "\033[%dG[ \033[33m%s\033[0m ]\r" "$(( col + 1 ))" "$cur_dir"
    PS1="${blue_p}\u${reset_p}@${green_p}\h${reset_p} ${symbol} "
  }
fi

# 共通設定
PROMPT_COMMAND=_build_prompt
hwd() { PROMPT_COMMAND=''; PS1="${blue_p}\u${reset_p}@${green_p}\h${reset_p} \$ "; }
swd() { PROMPT_COMMAND=_build_prompt; }
# --- End PROMPT ---


# OSごとの設定
if [ "Linux" = "$(uname)" ]; then
  :
elif [ "Darwin" = "$(uname)" ]; then
  :
elif [[ "$(uname)" = MINGW* ]]; then
  :
fi

# bash固有の補完設定
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# -- common options -------------------------------------------------
# base-files version 4.1-1
# User dependent .bashrc file

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
set -o notify
#
# Don't use ^D to exit
set -o ignoreeof
#
# Use case-insensitive filename globbing
shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups:ignorespace
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077


