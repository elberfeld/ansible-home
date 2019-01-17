
# Reference: https://linuxize.com/post/create-a-linux-swap-file/

# Create 1G Swap File 

```bash
fallocate -l 1G /swapfile
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
swapon --show
```

# Add to fstab 
/swapfile swap swap defaults 0 0


