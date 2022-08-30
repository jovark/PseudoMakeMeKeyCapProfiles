DESTDIR = stl

OPENSCAD_CMD = openscad --export-format binstl

mx: r1.stl r2.stl r3.stl thumb.stl
lp: lr2.stl lr3.stl lthumb.stl

all: mx lp

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

lr2.stl:
	${OPENSCAD_CMD} -D'row="r2"' -o ${DESTDIR}/$@ keeblp.scad

lr3.stl:
	${OPENSCAD_CMD} -D'row="r3"' -o ${DESTDIR}/$@ keeblp.scad

lthumb.stl:
	${OPENSCAD_CMD} -D'row="thumb"' -o ${DESTDIR}/$@ keeblp.scad
