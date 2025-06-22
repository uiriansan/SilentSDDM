{
  description = "A very customizable SDDM theme that actually looks good";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      sddm-silent = pkgs.callPackage ./default.nix {};
      default = self.packages.${system}.sddm-silent;
    };
  };
}
