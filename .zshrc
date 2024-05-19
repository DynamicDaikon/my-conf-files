#setting alias
alias cot='open -a coteditor'
alias f='open -a finder'
alias term='open -a terminal'
alias sf='open -a safari'
alias ch='open -a "Google Chrome"'
alias logpayara='cot /opt/homebrew/opt/payara/libexec/glassfish/domains/domain1/logs/server.log'
alias rancdsk='open -a RancherDesktop.app'
alias ec='open -a Eclipse_2022-12.app'
alias ll='ls -l'
alias l1='ls -1'
alias gip='cd ~/git/projects/ && echo "--------------" && l1 && echo "--------------"'
alias la='ls -a -1'

#setting path
export JAVA_HOME=`/usr/libexec/java_home -v 17`


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dynamic_daikon/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dynamic_daikon/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/dynamic_daikon/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dynamic_daikon/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup


echo hello!

# コマンドの実行ごとに改行
function precmd() {

    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status
  
  branch='\ue0a0'
  color='%{\e[38;5;' #  文字色を設定
  green='114m%}'
  red='001m%}'
  yellow='227m%}'
  blue='033m%}'
  reset='%{\e[0m%}'   # reset
  
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="${color}${green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="${color}${red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="${color}${red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="${color}${yellow}!"
    
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "${color}${red}$VS${reset}"
    return
  else
    # 上記以外の状態の場合
    branch_status="${color}${blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status} $branch_name${reset}"
}
 
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct

#zsh-autosuggestions
 if type brew &>/dev/null; then
   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   autoload -Uz compinit && compinit
 fi
 
 # コマンド画面表示名と色
 PROMPT="%F{215}Dynamic_Daikon%f:%F{078}%~%f"$'\n'"%# "
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/dynamic_daikon/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/dynamic_daikon/.bun/_bun" ] && source "/Users/dynamic_daikon/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
