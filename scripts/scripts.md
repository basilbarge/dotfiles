
# tmux_sessions

## Prerequisites

- [tmux](https://github.com/tmux/tmux/wiki)
- [fzf](https://github.com/junegunn/fzf)

## Usage

To use the tmux_sessions script you must first make sure that you have the $SESSION_DIRS environment variable set to a space separated string of all of the directories you want fzf to search for your projects. To do this you can add the following to your .bashrc (or your shell-specific alternative).

`
export SESSION_DIRS="/home/$USER/Projects /home/$USER/Documents" #...etc
`

Then by typing `tmux_sessions.sh' into your terminal the script will use the directories in that environement variable, run find to get all of the sub-directories (projects) and pipe the result into fzf. Choosing a directory in fzf will then open a new tmux session with the same name as the chosen directory, or if a session with that name already exists tmux will open the existing session.
