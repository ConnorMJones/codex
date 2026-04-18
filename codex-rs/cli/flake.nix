{
  description = "codex deps requirements";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          pkg-config
          openssl
          libcap
          fish
          gcc
          gnumake
          perl
        ];
        buildInputs = with pkgs; [
          openssl
          libcap
        ];

        OPENSSL_DIR = pkgs.openssl.dev;
        OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
        OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
      };
    };
}
