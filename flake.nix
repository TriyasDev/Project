{
  description = "Flutter Environment";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem ( system:
    let 
      pkgs = import nixpkgs {
        inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
      };
      buildToolsVersion = "34.0.0";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = [ "34.0.0" "28.0.3" ];
          platformVersions = [ "34" "36" ];
          abiVersions = [ "armebi-v7a" "arm64-v8a" "x86_64" ];
          includeEmulator = true;
          systemImageTypes = [ "google_apis_playstore" ];
        };
        androidSdk = androidComposition.androidsdk;
    in 
  {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        flutter
        androidSdk
        jdk17
        cmake
        ninja
        pkg-config
        gtk3
        mesa-demos
      ];
      shellHook = ''
        mkdir -p $ANDROID_HOME/licenses
        ln -sf ${androidSdk}/libexec/android-sdk/licenses/* $ANDROID_HOME/licenses 2>/dev/null || true
      '';
      ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
      ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
      JAVA_HOME = pkgs.jdk17;
      CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
    };
  });
}