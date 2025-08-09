{
  nixpkgs,
  defaultSystems,
  ...
}:
let
  forEachSystemWith =
    systems:
    {
      overlays ? [ ],
    }:
    fn:
    nixpkgs.lib.foldl nixpkgs.lib.recursiveUpdate { } (
      nixpkgs.lib.forEach systems (
        system:
        let
          pkgs = (import nixpkgs) {
            inherit system overlays;
          };
        in
        (fn { inherit pkgs system; })
      )
    );

  forEachSystem = systems: fn: forEachSystemWith systems { } fn;

  forEachDefaultSystemWith =
    {
      overlays ? [ ],
    }:
    fn:
    forEachSystemWith defaultSystems {
      inherit overlays;
    } fn;

  forEachDefaultSystem = fn: forEachDefaultSystemWith { } fn;
in
{
  inherit
    defaultSystems
    forEachSystem
    forEachSystemWith
    forEachDefaultSystemWith
    forEachDefaultSystem
    ;
}
