{
  description = "A flake using snowflake.lib.forEachDefaultSystemWith";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowflake = {
      url = "github:freshstrangemusic/snowflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      naersk,
      rust-overlay,
      snowflake,
      ...
    }:
    snowflake.lib.forEachDefaultSystemWith
      {
        overlays = [ (import rust-overlay) ];
      }
      (
        { pkgs, system }:
        let
          toolchain = pkgs.rust-bin.stable.latest.default;
          naersk-lib = pkgs.callPackage naersk {
            cargo = toolchain;
            rustc = toolchain;
          };
        in
        {
          defaultPackage.${system} = naersk-lib.buildPackage {
            src = ./.;
          };

          devShells.${system}.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              (toolchain.override {
                extensions = [ "rust-src" ];
              })

              pkg-config
            ];
          };
        }
      );
}
