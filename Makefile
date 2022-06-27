DESTDIR = stl

clean:
	rm -rf ${DESTDIR}/*

r1.stl:
	openscad -D'row="r1"' -o ${DESTDIR}/$@ keeb.scad

r2.stl:
	openscad -D'row="r2"' -o ${DESTDIR}/$@ keeb.scad

r3.stl:
	openscad -D'row="r3"' -o ${DESTDIR}/$@ keeb.scad

thumb.stl:
	openscad -D'row="thumb"' -o ${DESTDIR}/$@ keeb.scad

all: r1.stl r2.stl r3.stl thumb.stl
