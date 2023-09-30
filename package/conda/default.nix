{ micromamba , runCommand, cacert, curl, ... } : 
let envfile = ./env.yml;


# curl https://conda.anaconda.org/conda-forge/linux-64/repodata.json -o /tmp/conda/pkgs/cache/497deca9.json
# curl https://conda.anaconda.org/conda-forge/noarch/repodata.json -o /tmp/conda/pkgs/cache/09cdf8bf.json


# micromamba create -n warmup -y -v -f ./env.yml --no-env -r ./init  --json


env = runCommand "conda-install" { nativeBuildInputs = [ micromamba curl ]; buildInputs = [ cacert ]; }
        ''
root_prefix=/tmp/root_prefix
condarc=/tmp/.mambarc
cp -r ${./init} $root_prefix
chmod +w -R $root_prefix

ls -la $root_prefix
cat >$condarc <<EOL
envs_dirs:
  - $root_prefix/envs
pkgs_dirs:
  - $root_prefix/pkgs
channels:
  - conda-forge
EOL

export CONDA_OVERRIDE_LINUX=6
micromamba info --root-prefix $out --rc-file $condarc

micromamba create --offline --dry-run -n env -y -f ${envfile} --verbose --root-prefix $root_prefix --rc-file $condarc --json | tee $out
        ''; in env

# https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/tools/package-management/conda/default.nix#L86
# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'