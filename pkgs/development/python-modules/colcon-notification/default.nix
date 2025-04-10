{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  colcon,
  notify2,
  pytestCheckHook,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "colcon-notification";
  version = "0.3.0";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "colcon";
    repo = "colcon-notification";
    tag = version;
    hash = "sha256-78LruNk3KlHFgwujSbnbkjC24IN6jGnfRN+qdjvZh+k=";
  };
  build-system = [ setuptools ];
  dependencies = [
    colcon
    notify2
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "colcon_notification"
  ];

  pytestFlagsArray = [
    "--ignore=test/test_flake8.py"
    "--ignore=test/test_spell_check.py"
  ];

  meta = {
    description = "An extension for colcon-core to provide status notifications";
    homepage = "https://github.com/colcon/colcon-notification";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
