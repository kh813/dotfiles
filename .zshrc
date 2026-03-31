# .zshrc : 2026/04/01

# 共通設定の読み込み
if [ -f "${HOME}/.commonrc" ]; then
  source "${HOME}/.commonrc"
fi

# zsh固有の設定
# プロンプト設定
# 色を使用出来るようにする
autoload -Uz colors && colors

# プロンプト（OS共通）
PROMPT="%{${fg[blue]}%}%n%{${reset_color}%}@%{${fg[green]}%}%m%{${reset_color}%} %# "
RPROMPT="[ %{${fg[yellow]}%}%~%{${reset_color}%} ]"

# OS固有のプロンプト設定（必要に応じて上書き）
if [ "Linux" = "$(uname)" ]; then
  : # Linux固有の設定をここに追加
elif [ "Darwin" = "$(uname)" ]; then
  : # macOS固有の設定をここに追加
elif [[ "$(uname)" = MINGW* ]]; then
  : # Windows(MINGW)固有の設定をここに追加
fi

# 補完システムの初期化
autoload -Uz compinit
compinit

# 大文字小文字を区別しない補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 履歴保存管理
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000
SAVEHIST=1000

# 便利なオプション
setopt auto_cd              # ディレクトリ名のみでcdする
setopt auto_pushd           # cd時にディレクトリスタックにプッシュ
setopt pushd_ignore_dups    # 重複したディレクトリをスタックに追加しない
setopt share_history        # 複数のzshセッション間でヒストリを共有
setopt hist_ignore_dups     # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_space    # スペースで始まるコマンドをヒストリに追加しない
setopt extended_glob        # 拡張グロブを有効化
setopt transient_rprompt    # コマンド実行時に右プロンプトを消す

# --
# .aliasrc is imported from .commrc
# --  
# other aliases
#alias ls='ls --color=auto'
#alias ls='ls -G -F'
#alias less='less -rfS'


