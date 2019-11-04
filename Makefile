MAIN_SOURCE_FILE := FloppyCoasterCommon.scad
ALL := \
	exports/floppy-coaster-stackup.stl \
	exports/floppy-coaster-panel-with-cutout.dxf \
	exports/floppy-coaster-panel-with-cutout.svg \
	exports/floppy-coaster-panel-without-cutout.dxf \
	exports/floppy-coaster-panel-without-cutout.svg \
	Bill-of-materials.pdf

.PHONY: all clean

all: ${ALL}

exports/floppy-coaster-stackup.stl: exports/floppy-coaster-stackup.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

exports/floppy-coaster-panel-with-cutout.dxf: exports/floppy-coaster-panel-with-cutout.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

exports/floppy-coaster-panel-with-cutout.svg: exports/floppy-coaster-panel-with-cutout.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

exports/floppy-coaster-panel-without-cutout.dxf: exports/floppy-coaster-panel-without-cutout.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

exports/floppy-coaster-panel-without-cutout.svg: exports/floppy-coaster-panel-without-cutout.scad ${MAIN_SOURCE_FILE}
	openscad -o $@ $<

Bill-of-materials.pdf: Bill-of-materials.ods
	soffice --headless --convert-to pdf:writer_pdf_Export $<

clean:
	rm -f ${ALL}
