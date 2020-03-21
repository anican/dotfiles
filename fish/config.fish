
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/anican/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> custom_scripts >>>
# !! Contents within this block enable access to custom bash commands
set -gx PATH $PATH ~/.config/custom_scripts
alias zap="nohup zathura & exit"
alias gau="git add -u"
alias trinke="brew update && brew upgrade && brew cleanup && brew cask cleanup"
# <<< custom_scripts <<<

# Adds Ruby to path
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
# For compilers to find ruby you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/ruby/lib"
set -gx CPPFLAGS "-I/usr/local/opt/ruby/include"
# For pkg-config to find ruby you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/ruby/lib/pkgconfig"
