{ stdenv, fetchzip, unzip }:

stdenv.mkDerivation rec {
  name = "hammerspoon-${version}";
  version = "0.9.73";
  src =
    if stdenv.hostPlatform.system == "x86_64-darwin" then
      fetchzip {
        url = "https://github.com/Hammerspoon/hammerspoon/releases/download/${version}/Hammerspoon-${version}.zip";
        sha256 = "16wjrgqy6qjd9shqv76chlfijfin3anaqcfc96w82p5j330f19iz";
        stripRoot = false;
      }
    else throw "Architecture not supported";

  buildInputs = [ unzip ];

  installPhase = ''
    mkdir -p "$out/Applications"
    mv "$(pwd)/Hammerspoon.app" "$out/Applications/Hammerspoon.app"
  '';

  meta = with stdenv.lib; {
    description = "Hammerspoon OsX window manager";
    homepage = http://www.hammerspoon.org/;
    downloadPage = https://github.com/Hammerspoon/hammerspoon/releases;
    maintainers = with maintainers; [ cmsj ];
    license = licenses.mit;
    platforms = stdenv.lib.platforms.darwin;
  };
}
