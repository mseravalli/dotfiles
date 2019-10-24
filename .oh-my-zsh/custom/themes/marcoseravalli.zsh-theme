# shamelessly copied from: https://sites.google.com/a/google.com/bash-prompt-with-citc-client/home
# If in a CitC client will return name of it, otherwise will return "None"
function citc_prompt() {
 pwd | awk -F '/' '{
        for(i = 1; i <= NF; i++) {
          if( $i == "google3" ) {
            # Useful for Java devs to know if they are in /java/ or /javatests/
            if( $(i+1) == "javatests"){
              print $(i-1)":tests";
              exit;
            }
            # bright blue name and bright red citc
            print "%F{12}citc:(%F{9}" $(i-1) "%F{12})%F ";
            exit;
          }
        }
        print "";
}'
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
PROMPT+=' $(citc_prompt)$(git_prompt_info)%{$fg[cyan]%}%2d%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
