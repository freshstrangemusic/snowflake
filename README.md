# snowflake

snowflake is an alternative to [flake-utils].

## Usage

```nix
{
  inputs.snowflake.url = "github:freshstrangemusic/snowflake";

  outputs =
    {
      self,
      snowflake,
    }:
    snowflake.lib.forEachDefaultSystem (
      { pkgs, system }:
      {
        packges.${system}.default = pkgs.stdenv.mkDerivation {
          # ...
        };

        devShells.${system}.default = mkgs.mkShell {
          # ...
        };
      }
    );
}
```

## Templates

This flake provides a few templates:

* `default`: A flake that uses `snowflake.lib.forEachDefaultSystem`. See
  [nix-systems/default] for the list of default systems.
* `custom-systems`: A flake that uses `snowflake.lib.forEachSystem` with a
  custom list of systems.
* `rust`: A flake that uses `snowflake.lib.forEachDefaultSystemWith` in
  conjunction with [naersk] and [rust-overlay].


[flake-utils]: https://github.com/numtide/flake-utils
[nix-systems/default]: https://github.com/nix-systems/default
[naersk]: https://github.com/nix-community/naersk
[rust-overlay]: https://github.com/oxalica/rust-overlay
