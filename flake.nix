{
  description = "Tinted Gallery dev shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forEachSystem = f:
      nixpkgs.lib.genAttrs systems (
        system: let
          pkgs = import nixpkgs {inherit system;};
        in
          f pkgs
      );
  in {
    devShells = forEachSystem (
      pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            ruby
            vim
          ];

          shellHook = ''
            echo "Using Ruby at: $(command -v ruby)"
            ruby -v
          '';
        };
      }
    );
  };
}
