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
        # gnumake
      ];
    };

    devShells.nemu = pkgs.mkShell {
      packages = with pkgs;[
        # tools
        bison
        flex
      ];
      buildInputs = with pkgs; [
        # lib
        gcc
        gdb
        SDL2
        readline
        libllvm
      ];
    };

    devShells.npc = pkgs.mkShell {
      packages = with pkgs; [
        gcc
        gdb
        verilator
        gtkwave
        python3
      ];
      buildInputs = with pkgs; [
        # for nvboard
        SDL2
        SDL2_image
        SDL2_ttf
      ];
      shellHook = ''
        export PATH=$NVBOARD_HOME/scripts/:$PATH
      '';
    };

    devShells.nvboard = pkgs.mkShell {
      packages = with pkgs; [
        python3
        verilator
      ];
      buildInputs = with pkgs; [
        SDL2
        SDL2_image
        SDL2_ttf
      ];
    };

  });
}
