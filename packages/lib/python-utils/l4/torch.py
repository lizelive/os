import torch

TORCH_NAME_TO_DTYPES = { k : v for k in dir(torch) if isinstance( v := getattr(torch, k), torch.dtype) }

def parse_torch_dtype(dtype: str) -> torch.dtype:
    torch_dtype = getattr(torch, dtype, None)
    if not isinstance(torch_dtype, torch.dtype):
        return torch_dtype    
    raise ValueError(f"unknown dtype {dtype}")

def assert_torch_cuda():
    import torch
    assert torch.cuda.is_available(), "cuda is not available"
    
    # list all devices
    devices = [torch.device(f"cuda:{i}") for i in range(torch.cuda.device_count())]

    # check that all devices are available
    for device in devices:
        assert torch.cuda.get_device_properties(device).is_initialized, f"{device} is not initialized"
        # try to allocate memory
        try:
            torch.ones(1, device=device)
        except RuntimeError as e:
            raise RuntimeError(f"failed to allocate memory on {device}") from e
