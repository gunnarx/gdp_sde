export PATH="$PATH:~/bin:~/gdp_sdk/bin"
alias ll='ls -alF'

# Set up yocto SDK environment
SDK_SETUP="~/gdp-sdk/yocto-sdk/*/environment-setup-*"

[ -f $SDK_SETUP ] && . $SDK_SETUP
