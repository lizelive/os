{ ... }:
{
  services.xserver.enable = true;

  # hardware.opengl.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
