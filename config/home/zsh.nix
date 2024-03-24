{ config, lib, pkgs, ... }:

let inherit (import ../../options.nix) flakeDir theShell hostname; in
lib.mkIf (theShell == "zsh") {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    historySubstringSearch.enable = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VNTR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    initExtra = ''

      source ~/powerlevel10k/powerlevel10k.zsh-theme
      ZSH_THEME="powerlevel10k/powerlevel10k"
      zstyle ":completion:*" menu select
      zstyle ":completion:*" matcher-list "" "m:{a-z0A-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*"
      if type nproc &>/dev/null; then
        export MAKEFLAGS="$MAKEFLAGS -j$(($(nproc)-1))"
      fi
      bindkey '^[[3~' delete-char                     # Key Del
      bindkey '^[[5~' beginning-of-buffer-or-history  # Key Page Up
      bindkey '^[[6~' end-of-buffer-or-history        # Key Page Down
      bindkey '^[[1;3D' backward-word                 # Key Alt + Left
      bindkey '^[[1;3C' forward-word                  # Key Alt + Right
      bindkey '^[[H' beginning-of-line                # Key Home
      bindkey '^[[F' end-of-line                      # Key End
      neofetch
      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      if [ -f $HOME/.zshrc-personal ]; then
        source $HOME/.zshrc-personal
      fi
      eval "$(starship init zsh)"
      '';
    plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    initExtraFirst = ''
      HISTFILE=~/.histfile
      HISTSIZE=1000
      SAVEHIST=1000
      setopt autocd nomatch
      unsetopt beep extendedglob notify
      autoload -Uz compinit
      compinit
    '';
    sessionVariables = {

    };
    shellAliases = {
      sv="sudo nvim";
      flake-rebuild="nh os switch --nom --hostname ${hostname}";
      flake-update="nh os switch --nom --hostname ${hostname} --update";
      gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
      neofetch="neofetch --ascii ~/.config/ascii-neofetch";
      ga="git add";
      gaa="git add .";
       gaaa="git add --all";
       gau="git add --update";
       gb="git branch";
       gbd="git branch --delete ";
       gc="git commit";
       gcm="git commit --message";
       gcf="git commit --fixup";
       gco="git checkout";
       gcob="git checkout -b";
       gcom="git checkout master";
       gcod="git checkout dev";
       gd="git diff";
       gda="git diff HEAD";
       gi="git init";
       glg="git log --graph --oneline --decorate --all";
       gld="git log --pretty=format:'%h %ad %s' --date=short --all";
       gm="git merge --no-ff";
       gma="git merge --abort";
       gmc="git merge --continue";
       gpu="git pull";
       gpr="git pull --rebase";
       gr="git rebase";
       gs="git status";
       gss="git status --short";
       gst="git stash";
       gsta="git stash apply";
       gstd="git stash drop";
       gstl="git stash list";
       gstp="git stash pop";
       gsts="git stash save";
       gp="git push origin HEAD";
       gg="git status;git add .;git commit;git push";
       runkt="function _runkt() { filename=$(basename $1 .kt); kotlinc $1 -include-runtime -d $filename.jar && java -jar $filename.jar; }; _runkt";
       kotlinc="kotlinc -include-runtime";
       fzfc="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'; | xargs -o nvim";

    };
  };
}
