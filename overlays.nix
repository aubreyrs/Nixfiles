{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      inherit (unstable) code2prompt;
    })
  ];
}