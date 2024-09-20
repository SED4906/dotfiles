# dotfiles
Common NixOS configurations for my machines running it.

Of note:

`shuppet` - Microsoft Surface Go 3. Enrolling Secure Boot keys *just worked*. Nothing janky or unusual about it. I also used FDE, and was able to enroll the decryption keys into the TPM without issue. More computers should be like this. Secure Boot "Setup Mode" was enabled by selecting "None" in the Secure Boot configuration. It's as shrimple as that.

`nacli` - Acer Aspire A315-21-4098. A bit of trouble enrolling Secure Boot keys, but I figured it out eventually.

`litwick` - Asus TP200SA "Transformer Flip". Originally, this thing shipped with Windows 10... on a measly 32GB eMMC of internal storage. When I first installed Linux on this thing, Windows couldn't even download updates because it ran out of space. Later revisions of this hardware doubled the amount of internal storage. Enrolling the Secure Boot keys was janky, but eventually worked. Sometimes it hangs during bootup, as it did multiple times when trying to boot the minimal install image. Battery Health was 55% last I checked. Yikes.