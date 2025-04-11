{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  nix-update-script,
  pyxdg,
  setuptools,
}:

buildPythonPackage rec {
  pname = "scspell";
  version = "2.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "myint";
    repo = "scspell";
    rev = "v${version}";
    sha256 = "sha256-XiUdz+uHOJlqo+TWd1V/PvzkGJ2kPXzJJSe5Smfdgec=";
  };

  build-system = [ setuptools ];

  dependencies = [
    pyxdg
  ];

  doCheck = true;

  preCheck = ''
    export HOME=$TMPDIR
  '';

  passthru.tests = {
    version = {
      command = [
        "scspell"
        "--version"
      ];
      exit = 0;
    };
    help = {
      command = [
        "scspell"
        "--help"
      ];
      exit = 0;
    };
    basic-check = {
      command = ''
        export HOME=$TMPDIR
        cat > test_file.py << 'EOF'
        def hello_world():
            print("Hello, world!")
        EOF
        scspell test_file.py
      '';
      exit = 1; # Should exit with non-zero status when finding misspellings
    };
    updateScript = nix-update-script {
      attrPath = "pythonPackages.${pname}";
    };
  };

  meta = {
    description = "A spell checker for source code";
    homepage = "https://github.com/myint/scspell";
    license = lib.licenses.gpl2;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
