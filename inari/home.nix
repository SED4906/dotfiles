{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
    name = "Default";
    settings = {
      "browser.tabs.closeWindowWithLastTab" = false;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
    userChrome = ''
      .titlebar-buttonbox-container 
      {
        display:none !important;
      }
    '';
    };
  };
  home.stateVersion = "24.05";
}