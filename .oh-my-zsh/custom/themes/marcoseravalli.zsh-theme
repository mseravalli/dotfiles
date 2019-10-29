# shamelessly copied from: https://sites.google.com/a/google.com/bash-prompt-with-citc-client/home
# if I am currently under google3 don't run git
function vcs_info() {
  VCS_INFO=$( pwd | awk -F '/' '
    BEGIN{ citc_info=""; }
    {
      for(i = 1; i <= NF; i++) {
        if( $i == "google3" ) {
          citc_info=$(i-1)
        }
        if(length(citc_info) > 0 && $i == "javatests" ) {
          citc_info=citc_info ":tests"
        }
      }
    }
    END{ print citc_info; }
    '
  )

  if [ ! -z "${VCS_INFO}" ]; then
    echo -n "%B%F{blue}citc:(%F{red}${VCS_INFO}%F{blue})%f%b "; return
  fi

  ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{blue}git:(%F{red}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%F{blue})%b %{$fg[yellow]%}✗%f"
  ZSH_THEME_GIT_PROMPT_CLEAN="%F{blue})%b %{$fg[green]%}✓%f"

  VCS_INFO=$(git_prompt_info)

  echo -n "${VCS_INFO}"; return
}

function switch_citc_prompt() {
  swname=`echo -n "$(citctools info 2>/dev/null)" | grep "Switch client target:" | cut -d' ' -f4`
  if [ -n "$swname" ]
  then
    echo " ($swname)"
  fi
}

# Directory in the prompt will only show 2 levels
export PROMPT_DIRTRIM=2

# If you have prodaccessed prompt will look like:
#++<CitC_client> <dir> $ 
#or (if you have a switch client):
#++<CitC_client> <Switch_client_target> <dir> $ 
# Where the ++ is purple, Citc_client is yellow, Switch_client_target is green, dir is blue
#
# If you haven't prodaccessed it will look like:
#?? Needs prodaccess <dir> $ 
# Where the ?? Needs prodaccess is red, dir is blue

TITLEBAR="\[\e]0;\$(citc_prompt)\$(switch_citc_prompt)\a\]"

PROMPT="%n@%m %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}"
PROMPT+='$(vcs_info)%{$fg[cyan]%}%${PROMPT_DIRTRIM}d%{$reset_color%} '

