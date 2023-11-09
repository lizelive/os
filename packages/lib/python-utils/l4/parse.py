def parse_bool(s: str):
    "parse a bool from a string"
    match s.lower():
        case "true":
            return True
        case "false":
            return False
        case _:
            raise ValueError(f"invalid bool {s}")

def parse_any(s: str):
    "parse a bool, int, float, or str from a string"
    for parser in [parse_bool, int, float, str]:
        try:
            return parser(s)
        except ValueError:
            pass
    raise ValueError(f"invalid value {s}")

def parse_argv(argv: list[str]) -> dict:
    "parse argv into a dict"
    
    out = {}
    current = []
    for arg in argv:
        if arg.startswith("-"):
            key = arg.lstrip("-")
            current = out.setdefault(key, [])
        else:
            current.append(arg)

    for k in out:
        match out[k]:
            case []:
                out[k] = True
            case [v]:
                out[k] = parse_any(v)
            case vs:
                out[k] = [parse_any(v) for v in vs]
    
    return out
