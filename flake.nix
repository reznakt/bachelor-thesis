{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive)
            amsfonts
            amsmath
            babel
            biber
            biblatex
            booktabs
            caption
            comment
            csquotes
            datetime2
            enumitem
            float
            footmisc
            footnotebackref
            framed
            fvextra
            geometry
            glossaries
            graphics
            interval
            latexmk
            lineno
            mathdesign
            mathtools
            microtype
            minted
            morewrites
            multirow
            nag
            parskip
            pdfx
            scheme-medium
            setspace
            stackengine
            tabstackengine
            threeparttable
            todonotes
            upquote
            xcolor
            xmpincl
            ;
        };
      in
      {

        packages = {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "thesis";
            version = "0.0.0";

            src = ./.;

            buildInputs = [
              tex
              pkgs.python3Packages.pygments
            ];

            TEXMFVAR = "./.texmf-var";
            SOURCE_DATE_EPOCH = 0;

            buildPhase = ''
              latexmk -f thesis.tex || true
            '';

            installPhase = ''
              mkdir -p $out
              cp build/thesis.pdf $out/thesis.pdf
            '';
          };
        };
      }
    );
}
