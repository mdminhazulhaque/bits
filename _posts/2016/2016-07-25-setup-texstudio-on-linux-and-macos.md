---
layout: post
title: Setup TeXstudio on Linux and macOS
date: 2016-07-25
categories: tex
---

[TeXstudio](http://www.texstudio.org/) is a great integrated writing environment for creating LaTeX documents. TeXstudio needs local latex distribution in order to compile and preview documents.

## Setting up on Linux

Pakcages are available in official Debian/Ubuntu repository. Use `apt-get` to download them. I have mentioned some extra packages which are necessary if you intend to use special latex commands and classes.

```bash
apt-get install -y texstudio texlive-base texlive-binaries texlive-extra-utils texlive-font-utils texlive-fonts-recommended texlive-generic-recommended texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-pictures texlive-pstricks
```

## Setting up on macOS

TexStudio can easily be downloaded via `brew`. The app will be available at `/Applications`.

```bash
brew cask install texstudio
```

But you'll still need latex tools. Most popular distribution for macOS is mactex, but it's huge in size (approx. 2GB!) which causes a headache for Macbook Air users like me. So I suggest you download [mactex-basictex](https://tug.org/mactex/morepackages.html) package from their website and install it.

But wait! You'll still experience problems when compiling. TeXstudio will throw nasty errors for some missing components, i.e. `subfiles`, `appendix` etc (if you use them explicitly of course). Don't worry. mactex comes with texlive manager which can install extra components per your need.

First update TeXLive manager. Then install latex packages just like you do with `apt-get`.

```
sudo tlmgr update --self
sudo tlmgr install subfiles multirow multicolumn makecell tocloft appendix tocbibind
```

And you are done! Enjoy!
