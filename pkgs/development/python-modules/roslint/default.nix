{
  lib,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  catkin-pkg,

  # nativeCheckInputs
  pytestCheckHook,

}:

buildPythonPackage rec {
  pname = "roslint";
  version = "0.12.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ros";
    repo = "roslint";
    tag = "${version}";
    hash = "sha256-MvqS/l8JVWpNGOW4U1NETi6qhe8uPQqULpmJcwZ/ML0=";
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    catkin-pkg
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [
    "roslint"
  ];

  doCheck = false; # Disable tests since they're not being found

  meta = {
    description = "Lint macros for ROS packages";
    homepage = "http://wiki.ros.org/roslint";
    downloadPage = "https://github.com/ros/roslint";
    changelog = "https://github.com/ros/roslint/blob/${src.tag}/CHANGELOG.rst";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ guelakais ];
  };
}
