use <./Choc_Chicago_Steno.scad>
use <./Choc_Chicago_Steno_Convex.scad>
use <./Choc_Chicago_Steno_Thumb.scad>

module keycap_with_support(id, type = "alpha") {
	$fn = 16;
	radious = 0.75;

	translate([0,-16.0 / 2 + radious - 0.045,-radious * 2])
		color("red")
		cylinder(h=radious * 2,r=radious);
	if (type == "convex") {
		convex_keycap(keyID  = id,
		       cutLen = 0, //Don't change. for chopped caps
		       Stem   = true, //tusn on shell and stems
		       Dish   = true, //turn on dish cut
		       Stab   = 0,
		       visualizeDish = false, // turn on debug visual of Dish
		       crossSection  = false, // center cut to check internal
		       homeDot = false, //turn on homedots
		       Legends = false);
	} else {
		keycap(keyID  = id,
		       cutLen = 0, //Don't change. for chopped caps
		       Stem   = true, //tusn on shell and stems
		       Dish   = true, //turn on dish cut
		       Stab   = 0,
		       visualizeDish = false, // turn on debug visual of Dish
		       crossSection  = false, // center cut to check internal
		       homeDot = false, //turn on homedots
		       Legends = false);
	}
}

module generate_keycaps(id = 0,type = "alpha") {
	for ( j = [ 0 : 1 : 3 - 1]) {
		for ( i = [ 0 : 1 : 3 - 1]) {
			translate([17.7 * i, 16.5 * j, 0]) {
				if (i == 0 && j == 0) {
					translate([0, 0, -0.75 * 4]) 
						rotate([180, 0, 180])
						keycap_with_support(id, type);
				}
				keycap_with_support(id, type);
			}

		}
		translate([0, 16.5 * j, -0.75 ])
			translate([0,((-16.0) / 2 + 0.75 - 0.045), -0.75])
			color("red")
			rotate([180,-90,0])
			cylinder(h=(17.2 + 0.75 / 2) * 2, r=0.75);
	}

	translate([0,((-16.0) / 2 + 0.75 - 0.045), -0.75 * 2])
		color("red")
		rotate([-90,90,0])
		cylinder(h=16 * 3 , r=0.75);
}

row = "r2";

if (row == "r2") {
	generate_keycaps(0, "alpha");
}
if (row == "r3") {
	generate_keycaps(1, "alpha");
}
if (row == "thumb") {
	generate_keycaps(0, "convex");
}
