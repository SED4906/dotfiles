{ pkgs, config, ... }:
{
  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = { default-session = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet"; };
  };
  services.displayManager.sessionPackages = [
    (pkgs.writeTextFile {
      name = "cage-firefox-session";
      destination = "/share/wayland-sessions/cage-firefox.desktop";
      text = ''
        [Desktop Entry]
        Name=Firefox
        Exec=${pkgs.cage}/bin/cage -s -- ${pkgs.firefox}/bin/firefox
      '';
    } // { providedSessions = [ "cage-firefox" ]; })
  ];
  programs.firefox = {
    enable = true;
    preferences = {
      "browser.tabs.closeWindowWithLastTab" = false;
    };
  };
  users.users.user = {
    initialPassword = "password";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [];
  };
}
