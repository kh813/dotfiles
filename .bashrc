# .bashrc : 2026/04/01

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# 共通設定の読み込み
if [ -f "${HOME}/.commonrc" ]; then
  source "${HOME}/.commonrc"
fi


# --- PROMPT (Zsh-like Right Side: Final Fix for Mac) ---
# PS1用の色定義
blue_p="\[\e[34m\]"
green_p="\[\e[32m\]"
reset_p="\[\e[0m\]"

build_prompt() {
  local exit_status=$?
  local symbol="$"
  [[ $UID -eq 0 ]] && symbol="#"

  # 右側の文字列を準備
  local cur_dir="${PWD/#$HOME/~}"
  local r_str="[ $cur_dir ]"
  # 文字列の長さを取得
  local r_len=${#r_str}

  # --- 右端吸着マジック ---
  # \033[999C : カーソルを右端(999列目)まで移動
  # \033[${r_len}D : 文字列の長さ分だけ左(D)に戻る
  # これにより、文字数に関わらず最後の一文字が右端にピタリと止まります
  printf "\n\033[999C\033[${r_len}D\033[33m%s\033[0m\r" "$r_str"

  PS1="${blue_p}\u${reset_p}@${green_p}\h${reset_p} ${symbol} "
}
PROMPT_COMMAND=build_prompt


# bash固有の補完設定
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# OS固有の設定
if [ "Linux" = "$(uname)" ]; then
  # --- Linux (Bash 5.x+) 限定: 右プロンプト消去プロトコル ---
  build_prompt() {
    local cols=$(tput cols)
    local cur_dir="${PWD/#$HOME/~}"
    local r_str="[ $cur_dir ]"
    
    # DEBUGトラップ: コマンド実行直前に実行される
    # 1行上(1A)に移動し、行末まで消去(K)して、行頭に戻る(\r)
    trap 'echo -ne "\e[1A\e[K\r"; trap - DEBUG' DEBUG

    # 右寄せでパスを表示し、行頭に戻って左プロンプトを重ねる
    printf "\n\033[33m%${cols}s\033[0m\r" "$r_str"
    PS1="\[\e[34m\]\u\[\e[0m\]\[\e[32m\]@\h\[\e[0m\] $ "
  }
  PROMPT_COMMAND=build_prompt

elif [ "Darwin" = "$(uname)" ]; then
  # Mac (Bash 3.2) は安定性を優先した標準のbuild_promptを使用（事前定義されている前提）
  export BASH_SILENCE_DEPRECATION_WARNING=1
  # ※ Mac用のbuild_prompt関数は別途共通部分に記述しておいてください

elif [[ "$(uname)" = MINGW* ]]; then
  :
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


