DESTDIR = stl

OPENSCAD_CMD = openscad --export-format binstl

all: r1.stl r2.stl r3.stl thumb.stl

clean:
	rm -rf ${DESTDIR}/*

r1.stl:
	${OPENSCAD_CMD} -D'row="r1"' -o ${DESTDIR}/$@ keeb.scad

r2.stl:
	${OPENSCAD_CMD} -D'row="r2"' -o ${DESTDIR}/$@ keeb.scad

r3.stl:
	${OPENSCAD_CMD} -D'row="r3"' -o ${DESTDIR}/$@ keeb.scad

thumb.stl:
	${OPENSCAD_CMD} -D'row="thumb"' -o ${DESTDIR}/$@ keeb.scad
