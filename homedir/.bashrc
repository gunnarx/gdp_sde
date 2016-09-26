export PATH="$PATH:~/bin:~/gdp_sdk/bin"
alias ll='ls -alF'

# Set up yocto SDK environment
SDK_SETUP="~/gdp-sdk/yocto-sdk/*/environment-setup-*"

source ~/.bash-git-prompt/gitprompt.sh
GIT_PROMPT_ONLY_IN_REPO=1

if [ -f $SDK_SETUP ] ; then
  . $SDK_SETUP
  export SDK_ENV_ACTIVE=1  # will be used some time later
fi

