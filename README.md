<!-- Copyright (c) 2023 Ralf Grawunder -->

# FlashPrintConfig: manage your 3D printing settings in a dedicated configuration folder

## Preamble

**FlashPrintConfig** enables you to  maintain your **FlashPrint** settings easily with **Git**,
[like I do](https://github.com/R2-G2/FlashPrint.config).

## Setup

Create your own configuration and edit it to your likings.

```shell
cp config.dist.sh config.sh
editor config.sh
```

## Usage

### Universal

Simply run **FlashPrintConfig**.

This will back up directories from your **FlashPrint** configuration folder matching the ones located in your dedicated
configuration folder and replace them with symlinks to latter ones.

```shell
./FlashPrintConfig.sh
```

Optionally symlink **FlashPrintConfig** to a directory specified in your *PATH*.

```shell
sudo ln -s "$(readlink -m ./FlashPrintConfig.sh)" /usr/local/bin/FlashPrintConfig
```

Now you can run **FlashPrintConfig** even easier.

```shell
FlashPrintConfig
```

### Personal

I prefer a hidden directory inside my *HOME* which is added to the *PATH* via the
(/etc/)[bash.bashrc](https://gist.github.com/R2-G2/b71248030139bc9648b4b712e25621d5#file-bash-bashrc-ubuntu-sh-L83)
file.

```shell
ln -s "$(readlink -m ./FlashPrintConfig.sh)" ~/.bin/FlashPrintConfig
FlashPrintConfig
```

## Problems?

Fork! Fork it! Fork you! Fork me, right?
