{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    
      flake-utils.lib.eachSystem  (with flake-utils.lib.system; [ x86_64-linux aarch64-linux]) (
        system: let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
            };
          };
          
          # use requireFile to download the vscode-server-launcher
          # fetchurl to get it
          vscodeServerLauncher = pkgs.fetchurl {
            name = "code-server";
            url = "https://aka.ms/vscode-server-launcher/x86_64/unknown-linux-gnu";
            hash = "sha256-ohRYB8TsqNGxe/7KXnLOA7gdcHIuOFmq7QXzQv22wrU=";
            executable = true;
          };

          fetchIpfs 
          # installVscodeServer = pkgs.writeShellApplication {
          #   name = "install-vscode-server";
          #   runtimeInputs = with pkgs; [wget bash];
          #   text = ''
          #     echo "Installing vscode-server"
          #     wget -O- https://aka.ms/install-vscode-server/setup.sh | sh
          #   '';
          # };
        in {
          target = pkgs.stdenv.buildPlatform;
          # cudaCapabilities = pkgs.cudaPackages;
          # defaultPackage = pkgs.cudaPackages.cuda-samples;
          defaultPackage = vscodeServerLauncher;
        }
      );
}
