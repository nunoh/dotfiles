# Path to Oh My Fish install.
set -gx OMF_PATH /Users/Nuno/.local/share/omf

# Customize Oh My Fish configuration path.
# set -gx OMF_CONFIG /Users/Nuno/.config/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

source ~/.dotfiles/.aliases
source ~/.dotfiles/.exports
source ~/.dotfiles/.shortcuts

set -gx PATH $PATH /bin
set -gx PATH $PATH /usr/bin
set -gx PATH $PATH /usr/local/bin
set -gx PATH $PATH /usr/local/sbin
set -gx PATH $PATH /Users/Nuno/Development/adt-bundle-mac/sdk/build-tools/android-4.4W
set -gx PATH $PATH /Users/Nuno/Development/adt-bundle-mac/sdk/platform-tools
set -gx PATH $PATH /Users/Nuno/Development/adt-bundle-mac/sdk/tools
set -gx PATH $PATH /Users/Nuno/Qt/5.5/clang_64/bin

set -gx DOCKER_TLS_VERIFY "1";
set -gx DOCKER_HOST "tcp://192.168.99.100:2376";
set -gx DOCKER_CERT_PATH "/Users/Nuno/.docker/machine/machines/default";
set -gx DOCKER_MACHINE_NAME "default";

eval (hub alias -s)

function -e fish_preexec _run_fasd
  fasd --proc (fasd --sanitize "$argv") > "/dev/null" 2>&1
end

function j
  cd (fasd -d -e 'printf %s' "$argv")
end
