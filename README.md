# AoC 2024 - terrible solutions to stupid problems

This repo contains my AoC solutions for 2024. I'm not aiming for quality here; rather, I'm aiming for a quick and dirty solution to each problem. Usually this will mean hacking together something experimentally using [the rb command](https://github.com/thisredone/rb).

## How to run

Assuming you'd want to run the examples for whatever reason, the `run.rb` script is included for your convenience. To run all examples:

```
$ ./run.rb
```

To run a specific set of examples:

```
$ ./run.rb 2 3 5 7 11
```

## How to create an example

1. Create a folder with the name of the day of advent, left-padded with '0's to a length of 2. Example: `mkdir 05`.
2. Create a script `1.sh` in that folder which outputs the solution to part 1 if run from inside that folder. Make it executable.
3. Create a script `2.sh` in that folder which outputs the solution to part 2 if run from inside that folder. Make it executable.

It is recommended to put the input in a separate text file. E.g:

```sh
# 01/puzzle.in
# ... data goes here ...

# 01/1.sh
cat puzzle.in | rb '<solution to part 1>'

# 01/2.sh
cat puzzle.in | rb '<solution to part 2>'
```

Alternatively, you can put the code in a separate file as well, making the `1.sh` and `2.sh` file the minimal glue needed to run the examples:

```sh
# 01/puzzle.in
# ... data goes here ...

# 01/1.sh
cat puzzle.in | rb $(cat 1.rb)

# 01/1.rb
# ... solution to part 1 goes here ...

# 01/2.sh
cat puzzle.in | rb $(cat 2.rb)

# 01/2.rb
# ... solution to part 2 goes here ...
```

## Security

The `run.rb` script is attempting to run executable files on your computer. I haven't put a lot of effort into making sure that it's secure. Use at own risk.
