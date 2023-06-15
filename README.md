# My .dotfiles !

I have dotfiles for both windows and linux. View the appropriate directory for details.

## Bootstrap

### Windows

-   Install chocolatey
-   `choco install git make gsudo`
-   Clone in `~\dotfiles`
-   `make windows` (needs to be run in git bash)

### Linux

-   Generate ssh keys

```bash
ssh-keygen
cat .ssh/id_rsa.pub | clip.exe
```

- Paste public key in github
- Clone repo and 

```bash
sudo apt install -y make
cd ~
git clone git@github.com:maxencefrenette/dotfiles.git
cd dotfiles
make linux
```

## Inspiration

-   [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
-   [Cowboy's dotfiles](https://github.com/cowboy/dotfiles)
-   [Makefile for your dotfiles](https://polothy.github.io/post/2018-10-09-makefile-dotfiles/)
