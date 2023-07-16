{
  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 10;
    };

    timeout = 3;
    efi.canTouchEfiVariables = true;
  };

  boot.tmp.useTmpfs = true;
}
