# Linux Notes

To add a git bash command line prompt, add the following to the end of your .bashrc:

``` sh
# git-prompt.sh
if [ ! -f ~/.git-prompt.sh ]; then
    echo Downloading git-prompt.sh ...
    wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi
source ~/.git-prompt.sh
PS1=$(expr substr "$PS1" 1 $(expr length "$PS1" - 3))'$(__git_ps1 " (%s)")'${PS1: -3}
```

For better gunicorn defaults, add the following to the end of your .profile:

``` sh
# Gunicorn
export GUNICORN_CMD_ARGS="--reload --bind=0.0.0.0:8080 --access-logfile=- --error-logfile=- --workers=2 --threads=2"
```
