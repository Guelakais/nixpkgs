{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  # build-system
  setuptools,
  colcon,
  #dependencies
  pyaml,
  # tests
  pytestCheckHook,
  pytest-cov-stub,
  pytest-repeat,
  pytest-rerunfailures,
}:
buildPythonPackage rec {
  pname = "colcon-defaults";
  version = "0.2.9";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "colcon";
    repo = "colcon-defaults";
    tag = version;
    hash = "sha256-Nb6D9jpbCvUnCNgRLBgWQFybNx0hyWVLSKj6gmTWjVs=";
  };

  build-system = [
    setuptools
    colcon
  ];

  dependencies = [ pyaml ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov-stub
    pytest-repeat
    pytest-rerunfailures
  ];

  disabledTestPaths = [
    # Skip the linter and spell check tests that require additional dependencies
    "test/test_flake8.py"
    "test/test_spell_check.py"
  ];

  pythonImportsCheck = [ "colcon_core" ];

  pythonRemoveDeps = [
    # We use pytest-cov-stub instead (and it is not a runtime dependency anyways)
    "pytest-cov"
  ];

  meta = {
    description = "Extension for colcon to read defaults from a config file";
    homepage = "https://github.com/colcon/colcon-defaults";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
