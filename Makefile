NAME := floppy-coaster

ALL := \
	exports/${NAME}-stackup.stl \
	exports/${NAME}-panel-with-cutout.dxf \
	exports/${NAME}-panel-with-cutout.svg \
	exports/${NAME}-panel-without-cutout.dxf \
	exports/${NAME}-panel-without-cutout.svg \
	Bill-of-materials.pdf

.PHONY: all clean

all: ${ALL}

exports/${NAME}-stackup.stl: exports/${NAME}-stackup.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-panel-with-cutout.dxf: exports/${NAME}-panel-with-cutout.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-panel-with-cutout.svg: exports/${NAME}-panel-with-cutout.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-panel-without-cutout.dxf: exports/${NAME}-panel-without-cutout.scad ${NAME}.scad
	openscad -o $@ $<

exports/${NAME}-panel-without-cutout.svg: exports/${NAME}-panel-without-cutout.scad ${NAME}.scad
	openscad -o $@ $<

Bill-of-materials.pdf: Bill-of-materials.ods
	soffice --headless --convert-to pdf:writer_pdf_Export $<

clean:
	rm -f ${ALL}
