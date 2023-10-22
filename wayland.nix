{...}: {
    sound.enable = true;
    nixpkgs.config.pulseaudio = true;
    hardware.pulseaudio.enable = true;
    services.xserver.enable = true;
}
