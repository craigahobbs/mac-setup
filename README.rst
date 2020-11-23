Application Links
=================

`Chrome <https://www.google.com/chrome/>`__

`Docker <https://www.docker.com/get-started>`__

`Emacs <https://emacsformacosx.com/>`__

`GIMP <https://www.gimp.org/downloads/>`__

`Firefox <https://www.mozilla.org/en-US/firefox/new/>`__

`Parallels <https://my.parallels.com/login>`__

`Ubuntu Linux <https://ubuntu.com/download/desktop>`__


Git SSH Key
===========

To generate and copy a new git ssh key execute the following:

.. code-block:: sh

   ssh-keygen -t ed25519 -C macbook-pro
   cat ~/.ssh/id_ed25519.pub | pbcopy


Linux Notes
===========

To add a git bash command line prompt, add the following to the end of your .bashrc:

.. code-block:: sh

   # git-prompt.sh
   if [ ! -f ~/.git-prompt.sh ]; then
       echo Downloading git-prompt.sh ...
       wget -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
   fi
   source ~/.git-prompt.sh
   PS1=$(expr substr "$PS1" 1 $(expr length "$PS1" - 3))'$(__git_ps1 " (%s)")'${PS1: -3}

For better gunicorn defaults, add the following to the end of your .profile:

.. code-block:: sh

   # Gunicorn
   export GUNICORN_CMD_ARGS="--reload --bind=0.0.0.0:8080 --access-logfile=- --error-logfile=- --workers=2 --threads=2"
