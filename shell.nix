with import <nixpkgs> {};

androidenv.emulateApp {
  name = "emulate-MyAndroidApp";
  platformVersion = "28";
  abiVersion = "x86"; # armeabi-v7a, mips, x86_64
  systemImageType = "google_apis_playstore";
} shell.nix

# { pkgs ? import <nixpkgs> { } }:
#
# pkgs.mkShell 
# {
#   nativeBuildInputs = with pkgs; [
#   ];
#   shellHook = ''
#     echo "Hello in dev shell"
#   '';
# }
