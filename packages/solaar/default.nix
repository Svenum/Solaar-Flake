{ stdenv
, lib
, fetchurl
, fetchPypi
, python3Packages
, python3
, dbus
, dbus-glib
, pkg-config

, gobject-introspection
, gtk3
, wrapGAppsHook
, gdk-pixbuf
, libappindicator
, librsvg
}:

let
  release = "1.1.13";
  dbus-python = python3Packages.dbus-python.overrideAttrs (oldAttrs: {
    src = fetchPypi {
      pname = "dbus-python";
      version = "1.3.2";
      sha256 = "sha256-rWeBkwhhi1BpU3viN/jmjKHH/Mle5KEh/mhFsUGCSPg=";
    };
  });
in
python3Packages.buildPythonApplication rec{
  pname = "solaar-flake";
  version = release;

  src = fetchurl {
    url = "https://github.com/pwr-Solaar/Solaar/archive/refs/tags/${release}.tar.gz"; 
    hash = "sha256-VM//EkAZLpIAQAy+BtJCfx6kHHb3evr6LdP8XQM5Wtw=";
  };

  outputs = [ "out" "udev" ];

  nativeBuildInputs = [
    gdk-pixbuf
    gobject-introspection
    wrapGAppsHook
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
  ];

  # the -cli symlink is just to maintain compabilility with older versions where
  # there was a difference between the GUI and CLI versions.
  postInstall = ''
    ln -s $out/bin/solaar $out/bin/solaar-cli

    install -Dm444 -t $udev/etc/udev/rules.d rules.d-uinput/*.rules
  '';

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
    changelog = "https://github.com/pwr-Solaar/Solaar/releases/tag/${release}";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ "Svenum" ];
  };
}
