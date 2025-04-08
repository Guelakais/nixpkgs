{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  colcon,
  setuptools,
  argcomplete,
  pytestCheckHook,
  pytest-cov-stub,
  pytest-repeat,
  pytest-rerunfailures,
}:
buildPythonPackage rec {
  pname = "colcon-argcomplete";
  version = "0.3.3";
  src = fetchFromGitHub {
    owner = "colcon";
    repo = "colcon-argcomplete";
    tag = version;
    hash = "sha256-A6ia9OVZa+DwChVwCmkjvDtUloiFQyqtmhlaApbD7iI=";
  };
  build-system = [ setuptools ];
  dependencies = [
    colcon
    argcomplete
  ];
  pytestFlagsArray = [
    "--ignore=test/test_flake8.py"
    "--ignore=test/test_spell_check.py"
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov-stub
    pytest-repeat
    pytest-rerunfailures
  ];
  doCheck = true;
  pythonImportsCheck = [
    "colcon_argcomplete"
  ];
  meta = {
    description = "An extension for colcon-core to provide command line completion using argcomplete";
    homepage = "https://github.com/colcon/colcon-argcomplete";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
