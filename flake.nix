{
  description = "Idris2 packages and backends";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    idris2-flake = {
      url = github:idris-lang/Idris2;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # backends

    erlang = { url = github:chrrasmussen/Idris2-Erlang; flake = false; };
    dart = { url = github:bamboo/idris2dart; flake = false; };
    ocaml = { url = github:karroffel/Idris2-Ocaml; flake = false; };
    grin = { url = github:Z-snails/Idris2-Grin; flake = false; };
    lua = { url = github:Russoul/Idris2-Lua; flake = false; };
    mlf = { url = github:ziman/idris2-mlf; flake = false; };
    fsharp = { url = github:zenntenn/Idris2-FSharp; flake = false; };

    # packages

    bytes = { url = github:MarcelineVQ/idris2-bytes; flake = false; };
    clibs = { url = github:edwinb/idris2-clibs; flake = false; };
    comonad = { url = github:stefan-hoeck/idris2-comonad; flake = false; };
    concur-core = { url = github:bbarker/idris-concur-core; flake = false; };
    curl = { url = github:MarcelineVQ/idris2-curl; flake = false; };
    curl-wchresta = { url = github:wchresta/idris2-curl; flake = false; };
    dom = { url = github:stefan-hoeck/idris2-dom; flake = false; };
    elab-util = { url = github:stefan-hoeck/idris2-elab-util; flake = false; };
    elab-deriving = { url = github:MarcelineVQ/idris2-elab-deriving; flake = false; };
    extra = { url = github:tensorknower69/idris2-extra; flake = false; };
    extras = { url = github:mb64/idris2-extras; flake = false; };
    helloidris2 = { url = github:alexhumphreys/hello-idris2; flake = false; };
    hedgehog = { url = github:stefan-hoeck/idris2-hedgehog; flake = false; };
    hott = { url = github:Russoul/Idris2-HoTT; flake = false; };
    json = { url = github:jumper149/idris2-json; flake = false; };
    kladenets = { url = github:SmiVan/kladenets; flake = false; };
    lens = { url = github:bijan2005/idris2-lens; flake = false; };
    libgit = { url = github:bigs/idris2-libgit2; flake = false; };
    managed = { url = github:MarcelineVQ/idris2-managed; flake = false; };
    mysql = { url = github:thomasdziedzic/mysql-idris2; flake = false; };
    pretty-show = { url = github:stefan-hoeck/idris2-pretty-show; flake = false; };
    scientific = { url = github:jumper149/idris2-scientific; flake = false; };
    server = { url = github:ska80/idris2-server; flake = false; };
    sesh = { url = github:wenkokke/idris-sesh; flake = false; };
    sdl = { url = github:ShinKage/idris2-sdl; flake = false; };
    sop = { url = github:stefan-hoeck/idris2-sop; flake = false; };
    splitmix = { url = github:Z-snails/idris2splitmix; flake = false; };
    sqlite3 = { url = github:MarcelineVQ/idris-sqlite3; flake = false; };
    streaming = { url = github:MarcelineVQ/idris2-streaming; flake = false; };
    subsets = { url = github:stefan-hoeck/idris2-subsets; flake = false; };
    text = { url = github:Z-snails/idris2text; flake = false; };
    webidl = { url = github:stefan-hoeck/idris2-webidl; flake = false; };
    zmq = { url = github:KenyC/Idris2-ZeroMQ; flake = false; };

  };

  outputs = { self, nixpkgs, flake-utils, idris2-flake, ... }@ args:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        idris2-flake-packages = idris2-flake.packages.${system};
        buildIdris2Package = idris2-flake.buildIdris.${system};

      in
        {
          packages = {
            inherit (idris2-flake-packages) idris2;
            # json = (
            #   buildIdris2Package {
            #     projectName = "json";
            #     src = self.inputs.json;
            #     idrisLibraries = [];
            #   }
            # ).build;
            # ...
          };
          defaultPackage = idris2-flake-packages.idris2;
          devShell = idris2-flake.devShell;
        }
    );
}
