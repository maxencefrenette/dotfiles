# My .dotfiles !

I have dotfiles for both windows and linux. View the appropriate directory for details.

## Bootstrap

### Windows

-   Install chocolatey
-   `choco install git make gsudo`
-   Clone in `~\Repos\dotfiles`
-   `make windows`

### Linux

-   Configure ssh keys manually

```bash
cd ~
git clone git@github.com:maxencefrenette/dotfiles.git
cd dotfiles
make linux
```

## Inspiration

-   [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles)
-   [Cowboy's dotfiles](https://github.com/cowboy/dotfiles)
-   [Makeifle for your dotfiles](https://polothy.github.io/post/2018-10-09-makefile-dotfiles/)
