{
  description = "A flake using snowflake.lib.forEachDefaultSystem";

  inputs.snowflake.url = "github:freshstrangemusic/snowflake";

  outputs =
    {
      snowflake,
      ...
    }:
    snowflake.lib.forEachDefaultSystem (
      { pkgs, system }:
      {
        packages.${system}.default = pkgs.hello;
      }
    );
}
