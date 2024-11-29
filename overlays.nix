{ config, pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      inherit (pkgs) code2prompt;
    })
  ];
}