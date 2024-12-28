{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "commitmono-alex";
  version = "v143";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "CommitMono, Alex's variant";
    homepage = "https://commitmono.com/";
    platforms = platforms.all;
  };
}
