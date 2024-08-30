{
  description = "Flake for ysyx-workbench";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {self, nixpkgs, flake-utils, ...}@inputs :
  flake-utils.lib.eachDefaultSystem (system: 
  let
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    devShells.default = pkgs.mkShell {
      packages = with pkgs;[
        gcc
        gdb
      ];
    };

    devShells.nemu = pkgs.mkShell {
    # TODO: libreadline, libsdl2
      packages = with pkgs;[
        # tools
        bison
        flex

        # lib
        SDL2
        readline
        libllvm
      ];
    };
  });
}
