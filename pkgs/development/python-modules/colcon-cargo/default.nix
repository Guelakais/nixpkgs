{
  lib,
  buildPythonPackage,
  colcon,
  fetchFromGitHub,
  setuptools,
  pythonOlder,
  pytestCheckHook,
  toml,
}:
buildPythonPackage rec {
  pname = "colcon-cargo";
  version = "0.1.3";

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "colcon";
    repo = "colcon-cargo";
    tag = version;
    hash = "sha256-Do8i/Z1nn8wsj0xzCQdSaaXoDf9N34SiMb/GIe4YOs4=";
  };

  build-system = [ setuptools ];

  dependencies = [
    colcon
    toml
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pytestFlagsArray = [
    "--ignore=test/test_flake8.py"
    "--ignore=test/test_spell_check.py"
  ];

  pythonImportsCheck = [
    "colcon_cargo"
  ];

  meta = {
    description = "An extension for colcon-core to support Rust packages built with Cargo";
    homepage = "https://github.com/colcon/colcon-cargo";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
