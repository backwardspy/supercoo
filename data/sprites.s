sprmeta_t       .struct         ; sprite metadata
count           .byte ?         ; number of sprite shapes
                .byte ?         ; number of animations (unused)
bgc             .byte ?         ; background colour
mc_0            .byte ?         ; multicolour 0
mc_1            .byte ?         ; multicolour 1
                .byte ?, ?, ?   ; pad to 8 bytes
                .ends

make_sprmeta    .macro spd_file
                  .union
                    .binary \spd_file, 4, 5
                    .dstruct sprmeta_t
                  .endu
                .endm

  ;; 3 byte SPD header and 1 byte version number are skipped on import

* = ADDR_SPRMETA

pigeon_md       #make_sprmeta "../res/pigeon.spd"

  ;; sprite data structure:
  ;; $00 63b pixels
  ;; $3F  1b flags 0-3 colour, 4 overlay, 7 multi

  ;; 9 byte header is skipped

* = ADDR_SPRDATA

pigeon_spr      .binary "../res/pigeon.spd", 9
