# .[bash_]profile is loaded when the shell is a login shell
# and .bashrc when the shell is not login shell. On macOS, the Terminal app
# considers each shell to be login shell so for ~/.bashrc to work,
# it has to be sourced from here:
# In general, using the same config for both login and non-login shells
# is desirable.
[ -r ~/.bashrc ] && source ~/.bashrc
