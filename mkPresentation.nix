# Nix expression to generate a slidy presentation

{ # the nixpkgs set to use
  pkgs
, src
, name
, revealVersion ? "3.7.0"
, selfContained ? false
  # extra dependencies
, extraBuildInputs ? []
}:
let
  revealJS = fetchTarball "https://github.com/hakimel/reveal.js/archive/${revealVersion}.tar.gz";
in

with pkgs;
with pkgs.lib;

stdenv.mkDerivation rec {
  inherit name src;

  preferLocalBuild = true;
  allowSubstitutes = false;

  # dependencies declaration
  buildInputs = [ pandoc ] ++ extraBuildInputs;

  installPhase = ''
    for presentation in $(find . -name "*\.md"); do
      id="$(basename "$presentation" ".md")"
      path="$(dirname "$presentation")"
      mkdir -p "$out/$path"
      pandoc --to=revealjs --variable revealjs-url=${revealJS} --resource-path="$src/$path" --standalone ${optionalString selfContained "--self-contained"} --out="$out/$path/$id.html" "$presentation"
    done
  '';
}
