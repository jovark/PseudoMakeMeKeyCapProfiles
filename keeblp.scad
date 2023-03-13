use <./Choc_Chicago_Steno.scad>
use <./Choc_Chicago_Steno_Convex.scad>
use <./Choc_Chicago_Steno_Thumb.scad>

$fn = 16;

module keycap_with_support(id, type = "alpha") {
	radious = 0.75;
	size = type == "thumb" ? -26.4 : -16;

	translate([0, size / 2 + radious - 0.045,(-radious * 2) + 0.05])
		color("red")
		cylinder(h=radious * 2,r=radious);

	if (type == "convex") {
		convex_keycap(keyID  = id,
		       cutLen = 0, //Don't change. for chopped caps
		       Stem   = true, //tusn on shell and stems
		       Dish   = true, //turn on dish cut
		       Stab   = 0,
		       visualizeDish = false, // turn on debug visual of Dish
		       homeDot = false);
	}
	else if (type == "thumb") {
		thumb_keycap(keyID  = id,
		       cutLen = 0, //Don't change. for chopped caps
		       Stem   = true, //tusn on shell and stems
		       Dish   = true, //turn on dish cut
		       Stab   = 0,
		       StemRot = 0,//change stem orientation by deg
		       visualizeDish = false, // turn on debug visual of Dish
		       homeDot = false);
	} else {
		keycap(keyID  = id,
		       cutLen = 0, //Don't change. for chopped caps
		       Stem   = true, //tusn on shell and stems
		       Dish   = true, //turn on dish cut
		       Stab   = 0,
		       visualizeDish = false, // turn on debug visual of Dish
		       crossSection  = false, // center cut to check internal
		       homeDot = type == "hoaming" ? true : false, //turn on homedots
		       Legends = false);
	}
}

module identifier(t) {
	difference() {
		linear_extrude(1.5) square(5, center=true);
		translate([0, 0, -0.5])
			linear_extrude(1)
			mirror([1, 0, 0])
			text(t, size=2, halign="center", valign="center");
	}
}

module generate_keycaps(id = 0,type = "alpha", row) {
	for ( j = [ 0 : 1 : 3 - 1]) {
		for ( i = [ 0 : 1 : 3 - 1]) {
			translate([17.7 * i, 16.5 * j, 0]) {
				if (i == 0 && j == 0) {
					translate([17.7, -16.5, 0]){
						translate([0,((+16.0) / 2 - 0.75 * 2 + 0.045), -0.75 * 2])
							color("red")
							rotate([-90,-90,0])
							cylinder(h=17, r=0.75);
						rotate([0, 0, 180]) {
							translate([0, (-16 / 2) + 2.5, -0.75 * 2.5])identifier(row);
							keycap_with_support(id, type);
						}
					}
				}
				keycap_with_support(id, type);
			}
		}
		translate([0, 16.5 * j, -0.75 ])
			translate([-0.75,((-16.0) / 2 + 0.75 - 0.045), -0.75])
			color("red")
			rotate([180,-90,0])
			cylinder(h=(17.7 + 0.75) * 2, r=0.75);
	}
	translate([17.7,((-16.0) / 2 + 0.75 - 0.045), -0.75 * 2])
		color("red")
		rotate([-90,90,0])
		cylinder(h=16.5 * 2, r=0.75);
}

module thumb_keycaps() {
	module Set() {
		for ( i = [ 0 : 1 : 3 - 1]) {
			translate([i * 17.7, 0, 0]) {
				mirror([1, 0, 0])
					keycap_with_support(3, "thumb");
				translate([0,-26.4/2 - (0.75 * 2) - 0.5, -0.75])
					color("red")
					rotate([-90,-90,0])
					cylinder(h=0.75 * 4 + 0.5, r=0.75);
			}
		}
	}
	Set();
	mirror([1, 0, 0])
		rotate([0, 0, 180])
		translate([0, 26.9, 0])
		Set();

	translate([0, -26.4 / 2 - 0.75 + 0.045 + 0.5, -0.75])
		rotate([0, 90, 0])
		color("red")
		cylinder(h=17.7 * 2, r = 0.75);

}

row = "CT";

if (row == "R2") {
	generate_keycaps(0, "alpha", row);
}

if (row == "R3") {
	generate_keycaps(1, "alpha", row);
}

if (row == "TH") {
	generate_keycaps(1, "convex", row);
}

if (row == "HO") {
	generate_keycaps(1, "hoaming", row);
}

if (row == "CT") {
	thumb_keycaps();
}

/* keycap_with_support(1, "hoaming"); */
/* translate([17.7, 0, 0]) */
/* keycap_with_support(1, "hoaming"); */

/* translate([0, 16.5 * 0, -0.75 ]) */
/* translate([-0.75,((-16.0) / 2 + 0.75 - 0.045), -0.75]) */
/* color("red") */
/* rotate([180,-90,0]) */
/* cylinder(h=(17.7 + 0.75 + 0.75), r=0.75); */
