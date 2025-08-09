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

[flake-utils]: https://github.com/numtide/flake-utils
