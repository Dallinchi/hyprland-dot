if status is-interactive 
   set -g -x fish_greeting ' '
end

python ~/Code/Projects/cli-hello-terminal/main.py

# Created by `pipx` on 2024-10-05 19:45:29
set PATH $PATH /home/dallinchi/.local/bin

set full_env_name ""

function fish_prompt
    # Check if a pyenv version is set
    if set -q PYENV_VERSION
        set full_env_name (basename $PYENV_VERSION)
        # set env_parts (string split - $full_env_name)

        # Get the last word
        # set last_word $env_parts[(count $env_parts)]

        # Shorten all previous words to their first letter
        # set short_parts ""
        # set range (math (count $env_parts) - 1)
        # for part in $env_parts[1..$range]
            # set short_parts "$short_parts"(string sub -s 1 -l 1 $part)
        # end

        # Combine shortened parts with the last word
        # set short_env_name "$short_parts-$last_word"
    end

    echo (set_color purple)"╭─"(set_color blue)$full_env_name (set_color green)(whoami)"@"(set_color yellow)(hostname)" "(set_color purple)(prompt_pwd)
    echo "╰─➤ "
end

function peaclock-stopwatch
    peaclock --config-dir "/home/dallinchi/.config/peaclock/stopwatch/"
end

function peaclock-clock
    peaclock --config-dir "/home/dallinchi/.config/peaclock/default/"
end

function timer-delay
  python Code/Projects/cli-timer-delay $argv
end

function load_pyenv
  set -x PATH ~/.pyenv/bin $PATH
  pyenv init - | source
  pyenv virtualenv-init - | source

end
