{
  reese = {
    hardware = {
      gpu.nvidia.rtx3080 = true;
      tpm2 = true;
    };
    role = { ui = true; dev = true; ml = true; };
    disks = {
      # use btrfs for all other disks
    };
    publicKey = "ssh-rsa AAAAB3NzaC1yc2";
  };
  nook = {
    hardware = { };
    role = { storage = true; };
    publicKey = "ssh-rsa AAAAB3NzaC1yc22";
  };
  blathers = {
    hardware = {
      gpu.nvidia.rtx4090 = true;
    };
    role = { builder = true; ml = true; };
    publicKey = "ssh-rsa AAAAB3NzaC1yc2";
  };
}
