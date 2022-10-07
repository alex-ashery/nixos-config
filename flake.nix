{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  };

  outputs = inputs @ { self, nixpkgs }:
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs;
        }
      );
    };
}
