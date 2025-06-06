{
  lib,
  stdenv,
  fetchurl,
  fetchpatch,
  zlib,
  ncurses,
  fuse,
}:

stdenv.mkDerivation rec {
  pname = "wiimms-iso-tools";
  version = "3.05a";

  src = fetchurl {
    url = "https://download.wiimm.de/source/wiimms-iso-tools/wiimms-iso-tools.source-${version}.txz";
    hash = "sha256-5aikiPJkZf9OwD8QmQ7ijhBOtFQpkIErvb6gOvEu2L0=";
  };

  buildInputs = [
    zlib
    ncurses
    fuse
  ];

  patches = [
    ./fix-paths.diff

    # Pull pending upstream fix for ncurses-6.3:
    #  https://github.com/Wiimm/wiimms-iso-tools/pull/14
    (fetchpatch {
      name = "ncurses-6.3.patch";
      url = "https://github.com/Wiimm/wiimms-iso-tools/commit/3f1e84ec6915cc4f658092d33411985bd3eaf4e6.patch";
      sha256 = "18cfri4y1082phg6fzh402gk5ri24wr8ff4zl8v5rlgjndh610im";
      stripLen = 1;
    })
  ];

  postPatch = ''
    patchShebangs setup.sh gen-template.sh gen-text-file.sh
    substituteInPlace setup.sh --replace gcc "$CC"
    substituteInPlace Makefile --replace gcc "$CC"
  '';

  INSTALL_PATH = "$out";

  installPhase = ''
    mkdir "$out"
    patchShebangs install.sh
    ./install.sh --no-sudo
  '';

  meta = with lib; {
    homepage = "https://wit.wiimm.de";
    description = "Set of command line tools to manipulate Wii and GameCube ISO images and WBFS containers";
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ nilp0inter ];
  };
}
