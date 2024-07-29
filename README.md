# Bash dice roller

Bash dice roller is a shell script which lets a user roll virtual dice right in their terminal emulator of choice.

```
Usage: roll [options] NdM

Roll dice specified by NdM, where N is the number of dice and M is the number of sides.

Options:
  -s, --sum       Return the sum of the dice rolls (default behavior)
  -l, --list      List the results from all rolls
  -x, --max       Return the maximum result
  -m, --min       Return the minimum result
  -h, --help      Display this help message

Examples:
  roll 2d6          Roll two six-sided dice and return the sum
  roll -l 3d10      Roll three ten-sided dice and list the results
  roll -x 1d20      Roll one twenty-sided die and return the highest result
  roll -m 4d8       Roll four eight-sided dice and return the lowest result

Special cases:
  roll          Roll one six-sided die and return the result
  roll d4       Roll one four-sided die and return the result
```
---

[CC0](https://creativecommons.org/publicdomain/zero/1.0/) licensed | Author: Bendik J. Ferkingstad, https://github.com/bendikf
