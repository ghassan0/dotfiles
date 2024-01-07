# Download Znap, if it's not there yet.
[[ -f "${XDG_DATA_HOME}/zsh-snap/plugins/zsh-snap/znap.zsh" ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ${XDG_DATA_HOME}/zsh-snap/plugins/zsh-snap

source "${XDG_DATA_HOME}/zsh-snap/plugins/zsh-snap/znap.zsh"  # Start Znap

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# `znap prompt` makes your prompt visible in just 15-40ms!
# znap prompt sindresorhus/pure
znap prompt "romkatv/powerlevel10k"

# History file options
HISTFILE="${XDG_DATA_HOME}/zsh/histfile"
HISTSIZE=10000
SAVEHIST=10000
# Enable 'cd'-ing into a directory by just writing the directories name without 'cd'
setopt autocd
# Disable annoying beep sound in terminal
unsetopt beep
# Enable vi-style key bindings
bindkey -v


# Load aliases
[[ ! -f "${ZDOTDIR}/zshrc.d/aliases.zsh" ]] || source "${ZDOTDIR}/zshrc.d/aliases.zsh"
# Load functions
[[ ! -f "${ZDOTDIR}/zshrc.d/functions.zsh" ]] || source "${ZDOTDIR}/zshrc.d/functions.zsh"


# Load plugins
# improved vi-mode
znap source "jeffreytse/zsh-vi-mode"
znap source "zsh-users/zsh-autosuggestions"
znap source "zsh-users/zsh-syntax-highlighting"
znap source "marlonrichert/zsh-autocomplete"
# znap source "marlonrichert/zsh-edit"
# activate venv automatically
znap source "MichaelAquilina/zsh-autoswitch-virtualenv"


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f "${ZDOTDIR}/.p10k.zsh" ]] || source "${ZDOTDIR}/.p10k.zsh"


# # The following lines were added by compinstall
#
# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle ':completion:*' max-errors 2
# zstyle :compinstall filename '/home/ghassan/.config/zsh/.zshrc'
#
# autoload -Uz compinit
# compinit
# # End of lines added by compinstall

# Created by `pipx` on 2023-06-30 04:12:21
export PATH="$PATH:/home/ghassan/.local/bin"
