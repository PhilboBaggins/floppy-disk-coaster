MAIN_SOURCE_FILE := FloppyCoasterCommon.scad
ALL := exports/stackup.stl exports/panel-with-cutout.dxf exports/panel-without-cutout.dxf

.PHONY: all clean

all: ${ALL}

exports/stackup.stl: exports/stackup.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

exports/panel-with-cutout.dxf: exports/panel-with-cutout.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

exports/panel-without-cutout.dxf: exports/panel-without-cutout.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

clean:
	rm -f ${ALL}
