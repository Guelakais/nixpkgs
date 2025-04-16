{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  importlib-metadata,
  importlib-resources,
  setuptools,
  pytest,
  flake8,
}:

buildPythonPackage rec {
  pname = "ament-package";
  version = "0.17.1";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "ament";
    repo = "ament_package";
    rev = "${version}";
    hash = "sha256-/fOocC72wCEiCt8sTFvS1+d74MvoB/FXDRXSdykB+8E=";
  };
  build-system = [
    setuptools
  ];
  dependencies = [
    importlib-metadata
    importlib-resources
  ];

  # Completely disable all tests
  doCheck = false;
  doInstallCheck = false;

  meta = with lib; {
    description = "The parser for the manifest files in the ament buildsystem";
    homepage = "https://github.com/ament/ament_package";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
