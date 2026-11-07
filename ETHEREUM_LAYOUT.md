# Ethereum logo layout (21 nodes)

Slot numbers as seen from the front of the wall. Each row is half a module
offset from the one above (hex grid). Row 7 is left empty: that gap separates
the diamond from the bottom chevron. Ripples still cross it because
`MAX_LINK_HEX_DIST = 2`.

```
row  0              1
row  1           2     3
row  2        4     5     6
row  3     7     8     9    10
row  4        11    12    13
row  5           14    15
row  6              16
row  7           (empty gap)
row  8        17          18
row  9           19    20
row 10              21
```

| slot | pos command | slot | pos command | slot | pos command |
|---|---|---|---|---|---|
| 1 | `pos 3 0` | 8 | `pos 1 3` | 15 | `pos 1 5` |
| 2 | `pos 2 1` | 9 | `pos 2 3` | 16 | `pos 0 6` |
| 3 | `pos 3 1` | 10 | `pos 3 3` | 17 | `pos -2 8` |
| 4 | `pos 1 2` | 11 | `pos 0 4` | 18 | `pos 0 8` |
| 5 | `pos 2 2` | 12 | `pos 1 4` | 19 | `pos -2 9` |
| 6 | `pos 3 2` | 13 | `pos 2 4` | 20 | `pos -1 9` |
| 7 | `pos 0 3` | 14 | `pos 0 5` | 21 | `pos -2 10` |

Source of truth: `ethereum_layout.csv` (`hexnode.sh --pos` reads it).
