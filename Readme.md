# What is this

A demonstration how easy it is to build text only or graphical Linux VMs with nix on Darwin.

Kudos to

- [This blog article by tweag about how to achieve this](https://www.tweag.io/blog/2023-02-09-nixos-vm-on-macos/)
- [@afh](https://github.com/afh) for doing most of the research and getting this started

# How to use

If you do not have a remote builder setup for linux builds, run a linux builder

    nix run nixpkgs#darwin.linux-builder

or [enable it the nix-darwin linux builder](https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-nix.linux-builder.enable) or [the nix-rosetta-builder if you want rosetta support](https://github.com/cpick/nix-rosetta-builder)

Then run your custom NixOS VM

    # directly in terminal
    nix run
    # or
    nix run .#text
    # in a graphical window
    nix run .#graphic

Profit!
