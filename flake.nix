{
  description = "flake utilities";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }:
    {
      lib = (
        import ./default.nix {
          inherit nixpkgs;
          defaultSystems = import systems;
        }
      );

      templates = {
        default = {
          path = ./templates/default;
          description = "A flake using forEachDefaultSystem";
        };
      };
    };
}
