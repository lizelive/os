{
  user = "pmf";

  dns = {
    root = "lize.live";
  };

  machines = {
    reese = {
      hardware = {
        gpu = "NVIDIA GeForce RTX 3080";
      };
      role = {
        ui = true;
        dev = true;
        ml = true;
      };
      publicKey = "ssh-rsa AAAAB3NzaC1yc2";
    };
    nook = {
      hardware = { };
      role = {
        storage = true;
        drone = true;
      };
      publicKey = "ssh-rsa AAAAB3NzaC1yc22";
    };
    blathers = {
      role = {
        ai = true;
        drone = true;
        builder = true;
      };
      publicKey = "ssh-rsa AAAAB3NzaC1yc2";
    };
  };

  services = {
    drone = {
      enabled = true;
    };

    queen = {
      enabled = true;
    };

    postgres = {
      enabled = true;
    };

    ai = {
      models.stablediffusion = {
        enabled = true;
      };

    };
  };
}
