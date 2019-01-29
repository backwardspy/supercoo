APP=supercoo
PRG=$(APP).prg
D64=$(APP).d64
LST=$(APP).lst
SOURCES=main.s data/addr_defs.s data/sprites.s engine/input.s engine/mobs.s engine/gfx.s engine/screen.s

.PHONY: all d64 clean

all: $(PRG)

$(PRG): $(SOURCES)
	64tass -C -a -B -i -L $(LST) $< -o $@

d64: $(PRG)
	cc1541 -n $(APP) -i 01 -w $(PRG) $(D64)

clean:
	rm -f $(PRG) $(D64) $(LST)
