{ config, pkgs, ... }:

{
   home.username = "neb";
   home.homeDirectory = "/home/neb";

   # This value determines the Home Manager release that your configuration is
   # compatible with. This helps avoid breakage when a new Home Manager release
   # introduces backwards incompatible changes.
   #
   # You should not change this value, even if you update Home Manager. If you do
   # want to update the value, then make sure to first check the Home Manager
   # release notes.
   home.stateVersion = "25.05"; # Please read the comment before changing.

   home.packages = [
      pkgs.btop
      pkgs.flameshot
      pkgs.lazygit
      pkgs.rofi
      pkgs.fastfetch
      pkgs.tree
      pkgs.alacritty
      pkgs.xorg.xrandr
      pkgs.libxcvt
      pkgs.librewolf

      # It is sometimes useful to fine-tune packages, for example, by applying
      # overrides. You can do that directly here, just don't forget the
      # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # You can also create simple shell scripts directly inside your
      # configuration. For example, this adds a command 'my-hello' to your
      # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #    echo "Hello, ${config.home.username}!"
      # '')
   ];

   home.file = {
      # Files
      ".bashrc".source = ./dotfiles/bashrc;
      ".vimrc".source = ./dotfiles/vimrc;

      # Directories
      ".config/qtile" = {source = ./dotfiles/config/qtile; recursive=true;};
      "Pictures/Wallpapers" = {source = ./wallpapers; recursive=true;};
   };
   
   xfconf.settings = {
      xfce4-desktop = {
         "backdrop/screen0/monitorVirtual-1/workspace0/last-image" = "/home/neb/Pictures/Wallpapers/wp2.jpg";
      };      
   };

   # Home Manager can also manage your environment variables through
   # 'home.sessionVariables'. These will be explicitly sourced when using a
   # shell provided by Home Manager. If you don't want to manage your shell
   # through Home Manager then you have to manually source 'hm-session-vars.sh'
   # located at either
   #
   #   ~/.nix-profile/etc/profile.d/hm-session-vars.sh
   #
   # or
   #
   #   ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
   #
   # or
   #
   #   /etc/profiles/per-user/neb/etc/profile.d/hm-session-vars.sh
   #
   home.sessionVariables = {
      # EDITOR = "emacs";
   };

   # Let Home Manager install and manage itself.
   programs.home-manager.enable = true;
}
