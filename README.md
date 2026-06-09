# Fingerprint Manager

A simple GTK3 GUI to manage fingerprint authentication on Debian/Linux using `fprintd`.

Built for XFCE but works on any GTK3 desktop.

## Features

- List, enroll, and delete fingerprints for the current user
- Live enrollment progress with per-scan feedback and hand highlight
- Test/verify a fingerprint with visual result (✅ / ❌)
- Device error detection on startup (fprintd not running, no reader found)
- Spanish UI

## Requirements

- Debian 12+ / Ubuntu 22.04+ (or any distro with fprintd)
- A supported fingerprint reader ([check the list](https://fprint.freedesktop.org/supported-devices.html))
- `fprintd` — fingerprint daemon
- `python3-gi` + `gir1.2-gtk-3.0` — GTK3 Python bindings
- `python3-dbus` — D-Bus bindings

> **Goodix TLS 511 (27c6:5110) users:** the stock `libfprint` driver has a bug where
> enrollment succeeds but verification always fails. See
> [this PR](https://github.com/goodix-fp-linux-dev/libfprint/pull/37) for the fix.

## Installation

```bash
git clone https://github.com/Mounstroya/fingerprint-manager
cd fingerprint-manager
bash install.sh
```

Or manually:

```bash
sudo apt install fprintd python3-gi gir1.2-gtk-3.0 python3-dbus

mkdir -p ~/.local/bin
cp fingerprint-manager ~/.local/bin/
chmod +x ~/.local/bin/fingerprint-manager

cp fingerprint-manager.desktop ~/.local/share/applications/
```

## Usage

```bash
fingerprint-manager
```

Or open it from the app menu under **Settings → Huellas dactilares**.

## Enabling fingerprint login / sudo (PAM)

After enrolling a fingerprint, run:

```bash
sudo pam-auth-update
```

Enable **"Fingerprint authentication"** with the spacebar, then press Enter.

> ⚠️ Always keep a terminal with an active session open while testing PAM changes to avoid lockouts.

## Troubleshooting

**App doesn't open / module not found**
```bash
sudo apt install python3-gi gir1.2-gtk-3.0 python3-dbus
```

**"fprintd no está activo"**
```bash
sudo systemctl start fprintd
# To enable on boot:
sudo systemctl enable fprintd
```

**verify-no-match on Goodix 511**  
See [goodix-fp-linux-dev/libfprint#37](https://github.com/goodix-fp-linux-dev/libfprint/pull/37).

## License

MIT
