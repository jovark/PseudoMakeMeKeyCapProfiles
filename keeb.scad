use <./MX_DES_Standard.scad>
use <./MX_DES_Thumb.scad>

teclassioR1 = [
	[0, 0, 0, 0, 0],
	[-1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1],
];

teclassioR2 = [
	[-1, -1, -1, -1, -1],
	[1, 3, 1, 1, 1],
	[-1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1],
];

teclassioR3 = [
	[-1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1],
	[2, 2, 2, 2, 2],
	[-1, -1, -1, -1, -1],
];

teclassioThumb = [
  [],
  [],
  [],
  [7, 6, 3, -1, -1],
];

$radious = 0.75;

module mjf_supports(layout, row, column, size) {
	extra_side = 3.5;
	extra_heigt = 0.1;
	$fn = 16;

	color("red") {
		translate([0,0,$radious]) {
			translate([$radious, -size/2 + $radious - 0.45, -$radious * 3])
				rotate([180,90,0])
				cylinder(h=size + extra_side,r=$radious);
			/* translate([0, -size/2 + $radious*2, -$radious * 3]) */
			/* 	rotate([90,90,0]) */
			/* 	cylinder(h=(row != 0 ? (size + extra_side) : 0),r=$radious); */
			translate([0, -size/2 + $radious - 0.45, -$radious + extra_heigt])
				rotate([0,180,0])
				cylinder(h=$radious * 2 + extra_heigt,r=$radious);
		}
	}
	children();
}

module genside(layout) {
	for ( idx = [ 0 : 1 : len(layout) - 1]) {
		for ( idy = [ 0 : 1 : len(layout[idx]) - 1]) {
			if (layout[idx][idy] > -1) {
				if (idx > 2) {
				  translate([19*idy, 19*idx])
				  mjf_supports(layout=layout,size=17.16, row=idx, column=idy)
				  rotate([0,0,180])
				  thumb_keycap(
					  keyID  = layout[idx][idy], 
					  cutLen = 0, //Don't change. for chopped caps
					  Stem   = true, //tusn on shell and stems
					  Dish   = true, //turn on dish cut
					  Stab   = 0, 
					  visualizeDish = false, // turn on debug visual of Dish 
					  crossSection  = false, // center cut to check internal
					  homeDot = false, //turn on homedots
					  Legends = false
					 );
				} else {
				translate([19*idy, 19*idx])
				mjf_supports(layout=layout,size=17.16, row=idx, column=idy)
				keycap(
					keyID  = layout[idx][idy], 
					cutLen = 0, //Don't change. for chopped caps
					Stem   = true, //tusn on shell and stems
					Dish   = true, //turn on dish cut
					Stab   = 0, 
					visualizeDish = false, // turn on debug visual of Dish 
					crossSection  = false, // center cut to check internal
					homeDot = false, //turn on homedots
					Legends = false
				);
				}
			}
		}
	}
}

if (row == "r1") {
	translate([19, 0, 0])genside(teclassioR1);
	mirror([5*19, 0, 0]) genside(teclassioR1);
}

if (row == "r2") {
	translate([19, 0, 0])genside(teclassioR2);
	mirror([5*19, 0, 0]) genside(teclassioR2);
}

if (row == "r3") {
	translate([19, 0, 0])genside(teclassioR3);
	mirror([5*19, 0, 0]) genside(teclassioR3);
}

if (row == "thumb") {
	translate([19, 0, 0])genside(teclassioThumb);
	mirror([5*19, 0, 0]) genside(teclassioThumb);
}
