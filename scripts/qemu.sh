https://www.linux-tips.org/article/4/booting-from-an-iso-image-using-qemu

# create image once
qemu-img create kali.img 10G

# boot every time
qemu -boot d -cdrom ./kali-linux-1.1.0a-amd64.iso -m 512 -hda kali.img 

