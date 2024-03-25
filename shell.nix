{ pkgs ? import <nixpkgs> {
    config = {
        android_sdk.accept_license = true;
    };
} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.android-studio
    pkgs.androidsdk_9_0 # Adjust this to an available version
  ];

  shellHook = ''
    export ANDROID_HOME=${pkgs.androidsdk_9_0}
    export ANDROID_SDK_ROOT=${pkgs.androidsdk_9_0}
    export NIXPKGS_ACCEPT_ANDROID_SDK_LICENSE=1
  '';
}
