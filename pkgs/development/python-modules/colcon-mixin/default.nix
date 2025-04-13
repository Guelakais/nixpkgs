{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  colcon,
  pytest,
  pytest-cov,
  pytestCheckHook,
  setuptools,
}:

buildPythonPackage rec {
  pname = "colcon-mixin";
  version = "0.2.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "colcon";
    repo = "colcon-mixin";
    tag = version;
    hash = "sha256-XQpRDBTtrFOOlCRXKVImUtwrwirO0ELWifUpfQuyrrY=";
  };
  build-system = [ setuptools ];
  dependencies = [
    colcon
  ];

  nativeCheckInputs = [
    pytest
    pytest-cov
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "colcon_mixin"
  ];
  pytestFlagsArray = [
    "--ignore=test/test_flake8.py"
    "--ignore=test/test_spell_check.py"
  ];

  meta = {
    description = "Extension for colcon-core to provide mixin functionality";
    homepage = "https://github.com/colcon/colcon-mixin";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
