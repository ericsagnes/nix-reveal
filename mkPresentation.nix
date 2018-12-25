# Nix expression to generate a slidy presentation

{ # the nixpkgs set to use
  pkgs
, src
, name
, revealVersion ? "3.5.0"
  # extra dependencies
 ,extraBuildInputs ? []
  # assets to include in the result packages, typically examples
 ,assets ? []
}:
let
  revealJS = fetchTarball "https://github.com/hakimel/reveal.js/archive/${revealVersion}.tar.gz";
in

pkgs.stdenv.mkDerivation rec {
  inherit name src;

  preferLocalBuild = true;
  allowSubstitutes = false;

  # dependencies declaration
  buildInputs = with pkgs; [ pandoc ] ++ extraBuildInputs;

  installPhase = ''
    for presentation in $(find . -name "*\.md"); do
      id="$(basename "$presentation" ".md")"
      path="$(dirname "$presentation")"
      mkdir -p "$out/$path"
      pandoc --to=revealjs --variable revealjs-url=${revealJS} --resource-path="$path" --standalone --out="$out/$path/$id.html" "$presentation"
    done
  '';
}
