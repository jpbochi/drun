[![Run Status](https://api.shippable.com/projects/59288d3fb2fff10700c0ceda/badge?branch=master)](https://app.shippable.com/github/jpbochi/drun/runs?branchName=master)

# drun

This tool is a simple wrapper around `docker run` which will mount the current directory. It's useful when you have that python/node/ruby/whatever script that depends on locally installed stuff. Forget pyenv and rbenv. Just get inside a docker container with `drun`.

## Install

If you use [brew](http://brew.sh/), do: `brew tap jpbochi/tap && brew install drun`

If not, try: `curl -fsSL https://raw.github.com/jpbochi/drun/master/install.sh | bash`

If you want to install an specific version, try: `curl -fsSL https://raw.github.com/jpbochi/drun/master/install.sh | bash -s -- -v 1.2.1`

You can also install it somewhere else with: `curl -fsSL https://raw.github.com/jpbochi/drun/master/install.sh | bash -s -- -d ./temp`

## Suggested aliases

```
alias dr-node='drun -N -P'
alias dr-compose='drun -e HOME="$HOME" -I docker/compose:1.9.0'
alias dr-py='drun -I python:2.7'
```

## Examples

```
$ drun alpine sh
/Users/jpbochi/src/jp/drun # ls
README.md  drun       install
/Users/jpbochi/src/jp/drun # echo hello > world.txt
/Users/jpbochi/src/jp/drun #

$ ls
README.md drun      install   world.txt

$ drun alpine false

$ echo $?
1

$ node --version
v5.12.0

$ drun node:5.7 node --version
v5.7.1

$ ARRRRR=arrrrrrrrrrr MOARRR=moar drun -e ARR alpine env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=moby
TERM=xterm
ARRRRR=arrrrrrrrrrr
MOARRR=moar
HOME=/Users/jpbochi/src/jp/drun
no_proxy=*.local, 169.254/16
```
