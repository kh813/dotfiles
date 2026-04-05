# .bashrc : 2026/04/05

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

build_prompt() {
  local symbol="$"
  [[ $UID -eq 0 ]] && symbol="#"
  local cur_dir="${PWD/$HOME/\~}"
  local r_str="[ $cur_dir ]"
  local r_len=${#r_str}
  printf "\n\033[999C\033[${r_len}D\033[33m%s\033[0m\r" "$r_str"
  PS1="${blue_p}\u${reset_p}@${green_p}\h${reset_p} ${symbol} "
}
PROMPT_COMMAND=build_prompt

# OSごとのプロンプト設定
if [ "Linux" = "$(uname)" ]; then
  # Linux (Bash 4+): DEBUGトラップをbuild_promptの外で永続設定
  # コマンド実行直前に右プロンプト行（1行上）を消去する
  _rprompt_erase() {
    # PROMPT_COMMAND自身の実行はトラップしない
    [[ "${BASH_COMMAND}" == "build_prompt" ]] && return
    echo -ne "\e[1A\e[2K\r"
  }
  trap '_rprompt_erase' DEBUG

elif [ "Darwin" = "$(uname)" ]; then
  # Mac (Bash 3.2): build_promptをそのまま使用
  # DEBUGトラップはBash 3.2では動作が不安定なため使わない
  # → 右プロンプトは「残る」仕様とする（消去は行わない）
  export BASH_SILENCE_DEPRECATION_WARNING=1
  
  # cleanprompt で右プロンプトなしに切替、dirprompt で元に戻す
  hideprompt() { PROMPT_COMMAND=''; PS1="${blue_p}\u${reset_p}@${green_p}\h${reset_p} \$ "; }
  showprompt()   { PROMPT_COMMAND=build_prompt; }

elif [[ "$(uname)" = MINGW* ]]; then
  :
fi
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
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
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


