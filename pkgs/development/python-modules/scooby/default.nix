{
  lib,
  beautifulsoup4,
  buildPythonPackage,
  fetchFromGitHub,
  numpy,
  pytest-console-scripts,
  pytestCheckHook,
  pythonOlder,
  pyvips,
  scipy,
  setuptools-scm,
}:

buildPythonPackage rec {
  pname = "scooby";
  version = "0.10.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "banesullivan";
    repo = "scooby";
    tag = "v${version}";
    hash = "sha256-ldDmw2TDvXgfu0fMj6dSr2zh9WfYGNpBGZb3MixKq+k=";
  };

  build-system = [ setuptools-scm ];

  nativeCheckInputs = [
    beautifulsoup4
    numpy
    pytest-console-scripts
    pytestCheckHook
    pyvips
    scipy
  ];

  preCheck = ''
    export PATH="$PATH:$out/bin";
  '';

  pythonImportsCheck = [ "scooby" ];

  disabledTests = [
    # Tests have additions requirements (e.g., time and module)
    "test_get_version"
    "test_tracking"
    "test_import_os_error"
    "test_import_time"
    # TypeError: expected str, bytes or os.PathLike object, not list
    "test_cli"
  ];

  meta = with lib; {
    changelog = "https://github.com/banesullivan/scooby/releases/tag/v${version}";
    description = "Lightweight tool for reporting Python package versions and hardware resources";
    mainProgram = "scooby";
    homepage = "https://github.com/banesullivan/scooby";
    license = licenses.mit;
    maintainers = with maintainers; [ wegank ];
  };
}
