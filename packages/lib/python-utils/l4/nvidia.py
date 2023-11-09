import os.path

NVIDIACTL_DEVICE_DEVICES = ["/dev/nvidiactl", "/dev/dxg", "/dev/nvgpu"]

def has_nvidiactl_device_devices():
    return any(map(os.path.exists, NVIDIACTL_DEVICE_DEVICES))

def has_cuda_device():
    return has_nvidiactl_device_devices()
