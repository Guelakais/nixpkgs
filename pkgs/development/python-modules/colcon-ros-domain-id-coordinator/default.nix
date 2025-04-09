{
  lib,
  buildPythonPackage,
  colcon,
  fetchFromGitHub,
  pytestCheckHook,
  pytest-cov-stub,
  pytest-repeat,
  pytest-rerunfailures,
  setuptools,
}:
buildPythonPackage {
  pname = "colcon-ros-domain-id-coordinator";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "colcon";
    repo = "colcon-ros-domain-id-coordinator";
    rev = "0.2.1";
    hash = "sha256-8DTpixa5ZGuSOpmwoeJgxLQI+17XheLxPWcJymE0GqM=";
  };
  build-system = [ setuptools ];
  dependencies = [
    colcon
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-cov-stub
    pytest-repeat
    pytest-rerunfailures
  ];
  pytestFlagsArray = [
    "--ignore=test/test_flake8.py"
    "--ignore=test/test_spell_check.py"
  ];
  pythonImportsCheck = [
    "colcon_ros_domain_id_coordinator"
  ];
  doCheck = true;
  meta = with lib; {
    description = "An extension for colcon-core to coordinate ROS_DOMAIN_ID values across multiple terminals";
    homepage = "https://github.com/colcon/colcon-ros-domain-id-coordinator";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
