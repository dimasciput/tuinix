# tuinix

**A Pure Terminal Based Linux Experience**

tuinix is a terminal-centric Linux distribution built on NixOS with ZFS encryption. No desktop environment, no window manager -- just a carefully curated set of terminal tools on a reproducible, declarative foundation.

!!! tip "Ready to install?"
    Jump straight to the [Installation Guide](installation/index.md) to get started.

## Three Environments

tuinix has three distinct contexts. Pick the one that matches where you are right now.

### 1. Development Environment

*You're a contributor working on the tuinix flake, building ISOs, or hacking on modules.*

This is where the NixOS configuration, installer scripts, and ISO builder live. You work here on your existing machine (NixOS or any system with Nix installed) to build, test, and iterate.

```bash
git clone https://github.com/timlinux/tuinix.git
cd tuinix
./scripts/build-iso.sh          # Build the ISO
./scripts/run-vm.sh iso         # Test in a VM
nix flake check                 # Validate the flake
```

Full details: [Development Guide](contributing/development.md)

### 2. Installation Environment

*You have the ISO and want to install tuinix on a machine.*

The ISO is self-contained -- it includes both the installer and the complete system configuration. No internet connection is required.

- **[Bare Metal](installation/bare-metal.md)** -- Install on a physical machine from USB
- **[Virtual Machine](installation/vm.md)** -- Test in QEMU, virt-manager, or VirtualBox

### 3. Post-Install Environment

*You've installed tuinix and are booting into it for the first time.*

After installation you'll have a pure terminal environment with ZFS-encrypted storage, pre-configured tools, and your tuinix flake at `~/tuinix` for further customization.

Full details: [Post-Install Guide](usage/post-install.md)

## Features

- **NixOS + Flakes** -- Fully reproducible, declarative system configuration with instant rollbacks
- **ZFS with encryption** -- Advanced filesystem with compression, checksums, and snapshots
- **Terminal only** -- No X11, no Wayland. Minimal resource usage, maximum productivity
- **Self-contained ISO** -- Offline installation from a single bootable image
- **Interactive installer** -- Guided setup with disk selection, encryption, and locale configuration
