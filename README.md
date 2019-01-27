# supercoo

Live the best pigeon life you can live.

## Memory Map

VIC Bank | Address Range | Description
---------|---------------|------------
0        | $0000 - $00FF | Zeropage (See below)
.        | $0100 - $0800 | Unused
.        | $0801 - $08FF | Loader
.        | $0900 - $0FFF | Unused
.        | $1000 - $3FFF | Music data
1        | $4000 - $5BFF | Unused
.        | $5C00 - $5FFF | Sprite metadata
.        | $6000 - $7FFF | Sprite data (128 slots)
2        | $8000 - $BFFF | 6502 code
3        | $C000 - $CFFF | Unused
.        | $D000 - $DFFF | Reserved for I/O
.        | $E000 - $FFFF | Kernel ROM

### Zeropage Usage

None (yet.)
