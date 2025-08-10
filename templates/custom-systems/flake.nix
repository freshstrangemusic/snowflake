{
  description = "A flake using snowflake.lib.forEachSystem";

  inputs.snowflake.url = "github:freshstrangemusic/snowflake";

  outputs =
    { snowflake, ... }:
    snowflake.lib.forEachSystem [ "aarch64-darwin" "x64_64-darwin" ] (
      { pkgs, system }:
      {
        packages.${system}.default = pkgs.hello;
      }
    );
}
