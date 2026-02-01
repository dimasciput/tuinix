# ZFS Management

tuinix uses ZFS with encryption as its root filesystem. This guide covers day-to-day ZFS operations.

## Pool status

```bash
# Overall pool health
zpool status NIXROOT

# Dataset listing with space usage
zfs list
```

## Snapshots

Snapshots capture the state of a dataset at a point in time. They're instant and initially consume no additional space.

### Creating snapshots

```bash
# Snapshot the root dataset
sudo zfs snapshot NIXROOT/root@before-change

# Snapshot with a date-based name
sudo zfs snapshot NIXROOT/root@$(date +%Y-%m-%d)

# Snapshot all datasets recursively
sudo zfs snapshot -r NIXROOT@backup
```

### Listing snapshots

```bash
zfs list -t snapshot
```

### Rolling back

!!! warning
    Rolling back destroys all changes made after the snapshot.

```bash
sudo zfs rollback NIXROOT/root@before-change
```

### Deleting old snapshots

```bash
sudo zfs destroy NIXROOT/root@old-snapshot
```

## Compression

ZFS compression is enabled by default. Check the compression ratio:

```bash
zfs get compressratio NIXROOT
```

## Scrubbing

Scrubs verify data integrity by reading all blocks and checking checksums. Run periodically:

```bash
# Start a scrub
sudo zpool scrub NIXROOT

# Check scrub progress
zpool status NIXROOT
```

## Recovery

If your system won't boot:

1. Boot from the installation USB
2. Import and unlock:
   ```bash
   sudo zpool import -f NIXROOT
   sudo zfs load-key -a
   sudo zfs mount -a
   ```
3. Chroot in:
   ```bash
   sudo nixos-enter --root /mnt
   ```
4. Fix and rebuild:
   ```bash
   nixos-rebuild boot --flake /etc/tuinix#<hostname>
   ```
