# drun

This tool is a simple wrapper around `docker run` which will mount the current directory. It's useful when you have that python/node/ruby/whatever script that depends on locally installed stuff. Forget pyenv and rbenv. Just get inside a docker container with `drun`.

```
$ ./install

$ drun alpine sh
+ docker run ... --net=host -it --rm alpine sh
/Users/joao0191/src/jp/drun # ls
README.md  drun       install
/Users/joao0191/src/jp/drun # echo hello > world.txt
/Users/joao0191/src/jp/drun #

$ ls
README.md drun      install   world.txt

$ drun alpine false
+ docker run ... --net=host -it --rm alpine false

$ echo $?
1

$ node --version
v5.12.0

$ drun node:5.7 node --version
+ docker run ... --net=host -it --rm node:5.7 node --version
v5.7.1
```
