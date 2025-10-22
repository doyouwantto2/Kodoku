{ config, pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;

      daemon.settings = {
        dns = [ "1.1.1.1" "8.8.8.8" ];
        log-driver = "journald";
        registry-mirros = [ "https://mirror.gcr.io" ];
        storage-driver = "overlay2";
      };

      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    arion = {
      backend = "docker";
    };

  };
}
