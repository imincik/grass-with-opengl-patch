
{ self, inputs, config, lib, pkgs, ... }:

let
  geopkgs = inputs.geonix.packages.${pkgs.system};
  grass = self.packages.${pkgs.system}.grass;

in {
  
  name = "grassgl";

  packages = [ grass ];

  nixgl.enable = true;

  enterShell = ''
    [ ! -d grassdata ] && \
      grass \
        --tmp-location EPSG:4326 \
        --exec g.download.location https://grass.osgeo.org/sampledata/north_carolina/nc_basic_spm_grass7.tar.gz name=nc_basic path=./grassdata

    nixGLIntel grass --gui ./grassdata/nc_basic/PERMANENT
  '';

}
