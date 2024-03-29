if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g -x fish_greeting ' '
end

python ~/code/Python/CODETO/HelloTerminal/main.py

set -x PATH ~/.pyenv/bin $PATH
eval (pyenv init - | source)
eval (pyenv virtualenv-init - | source)

function fish_prompt
    if set -q PYENV_VIRTUAL_ENV
        echo -n -s (set_color blue)(basename $PYENV_VIRTUAL_ENV)" "
    end
    echo -n (set_color green)(whoami)"@"(set_color yellow)(hostname)": "(set_color purple)(prompt_pwd)": "
end
