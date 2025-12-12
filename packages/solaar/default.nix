{ stdenv
, lib
, fetchurl
, python3Packages

, gobject-introspection
, gtk3
, wrapGAppsHook3
, gdk-pixbuf
, libappindicator
, librsvg
}:

python3Packages.buildPythonApplication rec{
  pname = "solaar-flake";
  version = "1.1.18";

  src = fetchurl {
    url = "https://github.com/pwr-Solaar/Solaar/archive/refs/tags/${version}.tar.gz"; 
    hash = "sha256-0Ut2o2LyoeU9nSnAUxLsO9ULpoUigL0gAZopQRtNRmk=";
  };

  outputs = [ "out" "udev" ];

  nativeBuildInputs = [
    gdk-pixbuf
    gobject-introspection
    wrapGAppsHook3
  ];

  buildInputs = [
    libappindicator
    librsvg
  ];

  propagatedBuildInputs = with python3Packages; [
    evdev
    gtk3
    psutil
    pygobject3
    pyudev
    pyyaml
    xlib
    dbus-python
    typing-extensions
  ];

  # the -cli symlink is just to maintain compabilility with older versions where
  # there was a difference between the GUI and CLI versions.
  postInstall = ''
    ln -s $out/bin/solaar $out/bin/solaar-cli

    install -Dm444 -t $udev/etc/udev/rules.d rules.d-uinput/*.rules
  '';

  pyproject = true;
  build-system = with python3Packages; [ setuptools ];
  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  # no tests
  doCheck = false;

  pythonImportsCheck = [ "solaar" ];

  meta = with lib; {
    mainProgram = "solaar";
    homepage = "https://github.com/pwr-Solaar/Solaar";
    description = "Linux device manager for Logitech devices";
    platforms = with platforms; linux;
    changelog = "https://github.com/pwr-Solaar/Solaar/releases/tag/${version}";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ "Svenum" ];
  };
}
