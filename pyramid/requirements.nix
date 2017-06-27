# generated using pypi2nix tool (version: 1.8.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -v -V 3.5 -O ../overrides.nix -r requirements.txt
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python35;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i               -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"                  $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python35-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable}               python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs //                                            { meta = drv.meta; });
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "PasteDeploy" = python.mkDerivation {
      name = "PasteDeploy-1.5.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0f/90/8e20cdae206c543ea10793cbf4136eb9a8b3f417e04e40a29d72d9922cbd/PasteDeploy-1.5.2.tar.gz"; sha256 = "d5858f89a255e6294e63ed46b73613c56e3b9a2d82a42f1df4d06c8421a9e3cb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonpaste.org/deploy/";
        license = licenses.mit;
        description = "Load, configure, and compose WSGI applications and servers";
      };
    };



    "WebOb" = python.mkDerivation {
      name = "WebOb-1.7.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1a/2b/322d6e01ba19c1e28349efe46dab1bd480c81a55af0658d63dc48ed62ee6/WebOb-1.7.2.tar.gz"; sha256 = "0dc8b30bdbf15d8fd1a967e30ece3357f2f468206354f69213e57b30a63f0039"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://webob.org/";
        license = licenses.mit;
        description = "WSGI request and response object";
      };
    };



    "hupper" = python.mkDerivation {
      name = "hupper-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2e/07/df892c564dc09bb3cf6f6deb976c26adf9117db75ba218cb4353dbc9d826/hupper-1.0.tar.gz"; sha256 = "afb9584fc387c962824627bb243d7d92c276df608a771b17c8b727a7de34920a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Pylons/hupper";
        license = licenses.mit;
        description = "Integrated process monitor for developing and reloading daemons.";
      };
    };



    "plaster" = python.mkDerivation {
      name = "plaster-0.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/99/b3/d7ca1fe31d2b56dba68a238721fda6820770f9c2a3de17a582d4b5b2edcc/plaster-0.5.tar.gz"; sha256 = "2a028938dcbf41033c5d377363781b2528151b0159201587c41e7a4c74bc887c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docs.pylonsproject.org/projects/plaster/en/latest/";
        license = licenses.mit;
        description = "A loader interface around multiple config file formats.";
      };
    };



    "plaster-pastedeploy" = python.mkDerivation {
      name = "plaster-pastedeploy-0.3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c6/60/c6a8d3f81726c7fa29a17be20a71578343aa39af9054ea97a6e8572bbe69/plaster_pastedeploy-0.3.1.tar.gz"; sha256 = "68d3f7074545c6b9823a9a0850b9a78fdf3cdc7bdb1c0519912781dc5e3a8980"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PasteDeploy"
      self."plaster"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Pylons/plaster_pastedeploy";
        license = licenses.mit;
        description = "A loader implementing the PasteDeploy syntax to be used by plaster.";
      };
    };



    "pyramid" = python.mkDerivation {
      name = "pyramid-1.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b0/73/715321e129334f3e41430bede877620175a63ed075fd5d1fd2c25b7cb121/pyramid-1.9.tar.gz"; sha256 = "a1292c80d1cd776552d4a0e7549766829c81fa9e21516b5a4ce176d5d50d7e01"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PasteDeploy"
      self."WebOb"
      self."hupper"
      self."plaster"
      self."plaster-pastedeploy"
      self."repoze.lru"
      self."translationstring"
      self."venusian"
      self."zope.deprecation"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://trypyramid.com";
        license = "License :: Repoze Public License";
        description = "The Pyramid Web Framework, a Pylons project";
      };
    };



    "repoze.lru" = python.mkDerivation {
      name = "repoze.lru-0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6e/1e/aa15cc90217e086dc8769872c8778b409812ff036bf021b15795638939e4/repoze.lru-0.6.tar.gz"; sha256 = "0f7a323bf716d3cb6cb3910cd4fccbee0b3d3793322738566ecce163b01bbd31"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = "License :: Repoze Public License";
        description = "A tiny LRU cache implementation and decorator";
      };
    };



    "translationstring" = python.mkDerivation {
      name = "translationstring-1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5e/eb/bee578cc150b44c653b63f5ebe258b5d0d812ddac12497e5f80fcad5d0b4/translationstring-1.3.tar.gz"; sha256 = "4ee44cfa58c52ade8910ea0ebc3d2d84bdcad9fa0422405b1801ec9b9a65b72d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pylonsproject.org";
        license = "BSD-like (http://repoze.org/license.html)";
        description = "Utility library for i18n relied on by various Repoze and Pyramid packages";
      };
    };



    "venusian" = python.mkDerivation {
      name = "venusian-1.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/38/24/b4b470ab9e0a2e2e9b9030c7735828c8934b4c6b45befd1bb713ec2aeb2d/venusian-1.1.0.tar.gz"; sha256 = "9902e492c71a89a241a18b2f9950bea7e41d025cc8f3af1ea8d8201346f8577d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pylonsproject.org";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "A library for deferring decorator actions";
      };
    };



    "zope.deprecation" = python.mkDerivation {
      name = "zope.deprecation-4.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/51/85/b9d2fdcaf38ce3271ad759c7e8f0e9a28f6d900c1ad495085e4ab1de3795/zope.deprecation-4.2.0.tar.gz"; sha256 = "ff32c5bb5388b77b22c83ed1f1aa01cdbb076d9f2cfa2b825450ce9e2ecfd738"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.deprecation";
        license = licenses.zpt21;
        description = "Zope Deprecation Infrastructure";
      };
    };



    "zope.interface" = python.mkDerivation {
      name = "zope.interface-4.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c5/88/93373971f893714f0dc15e09696ec4886ee8b4e561ce5ae45612c2c516c4/zope.interface-4.4.2.tar.gz"; sha256 = "4e59e427200201f69ef82956ddf9e527891becf5b7cde8ec3ce39e1d0e262eb0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/zope.interface";
        license = licenses.zpt21;
        description = "Interfaces for Python";
      };
    };

  };
  overrides = import ./requirements_override.nix { inherit pkgs python; };
  commonOverrides = [
    (import ../overrides.nix { inherit pkgs python ; })
  ];

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            ([overrides] ++ commonOverrides)
         )
   )