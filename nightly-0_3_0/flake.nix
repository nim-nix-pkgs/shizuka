{
  description = ''The Nim framework for VK.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-shizuka-nightly-0_3_0.flake = false;
  inputs.src-shizuka-nightly-0_3_0.ref   = "refs/tags/nightly-0.3.0";
  inputs.src-shizuka-nightly-0_3_0.owner = "ethosa";
  inputs.src-shizuka-nightly-0_3_0.repo  = "shizuka";
  inputs.src-shizuka-nightly-0_3_0.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-shizuka-nightly-0_3_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-shizuka-nightly-0_3_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}