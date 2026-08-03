{
  description = "A Collection of Personal Nix Flake Templates";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
  };


  outputs = { nixpkgs, self }: {

    templates = {
      default = self.templates.trivial;

      trivial = {
        path = ./templates/trivial;
        description = "Starter template";
      };

      python-uv = {
        path = ./templates/python-uv;
        description = "Starter python + uv template";
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
