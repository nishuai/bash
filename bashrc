export LS_COLORS='di=0;36'
# Set the values for some environment variables:
export MINICOM="-c on"
export MANPATH=/usr/local/man:/usr/man:/usr/X11R6/man
export LESSOPEN="|lesspipe.sh %s"
export LESS="-M"
export PATH=$PATH:~/software/GATK/:~/software/picard/
export PYTHONPATH=~/appl_taito/lib/python2.6/site-packages:$PYTHONPATH
export PATH=$PATH:~/.local/bin/
export PATH=$PATH:~/appl_taito/bin
export PYTHONPATH=~/.local/lib64/python2.6/site-packages/:$PYTHONPATH
export PATH=$PATH:~/appl_taito/Mira/mira_4.0.2_linux-gnu_x86_64_static/bin/
export PATH=$PATH:~/appl_taito/weblogo/
export PATH=$PATH:~/appl_taito/HOMER/bin/
# User-defined section

export TERM=xterm-color
alias ls='ls -F --color'
alias ll='ls -lh'
alias la='ls -a'
alias lal='la -alh'
alias cdup='cd ..'

alias giftcurs='giFTcurs'
alias gui='startxfce4 -nolisten tcp'
alias fold='./FAH4Console-Linux.exe -advmethods -forceSSE'
alias grep='grep --color=auto'
alias sq='squeue -l -u shni'
# BLACK='[30'
# RED='[31'
# GREEN='[32'
# YELLOW='[33'
# BLUE='[34'
# MAGENTA='[35'
# CYAN='[36'
# WHITE='[37'

#bjork - green
PS1='\[\e[32;1m\]\u@\h:\[\e[37;1m\]\w \$\[\e[0m\] '

#vortex
#PS1='\[\e[37;1m\]\u@\h:\[\e[34;1m\]\w \$\[\e[0m\] '

#grand canyon
#PS1='\[\e[37;1m\]\u@\h:\[\e[31;1m\]\w \$\[\e[0m\] '

#basic
#PS1='\[\e[36;1m\]\u@\h:\[\e[34;1m\]\w \$\[\e[0m\] \e]2;\w\a'
