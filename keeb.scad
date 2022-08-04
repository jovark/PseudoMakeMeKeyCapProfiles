use <./MX_DES_Standard.scad>
use <./MX_DES_Thumb.scad>

R1 = [
      [0, 0, 0, 0, 0],
      [],
      [],
      [],
      ];

R2 = [
      [],
      [1, 3, 1, 1, 1],
      [],
      [],
      ];

R3 = [
      [],
      [],
      [2, 2, 2, 2, 2],
      [],
      ];

Thumb = [
	 [],
	 [],
	 [],
	 [7, 6, 3, -1, -1],
	 ];


/* Disable support generation */
gen_support = 1;

$radious = 0.75;

module mjf_supports(layout, size, gen_support) {
  extra_side = 3.5;
  extra_heigt = 0.1;
  $fn = 16;

  if (gen_support > 0) {
    color("red") {
	translate([0,0,$radious]) {
	translate([$radious, -size/2 + $radious - 0.45, -$radious * 3])
	    rotate([180,90,0])
	    cylinder(h=size + extra_side,r=$radious);
	translate([0, -size/2 + $radious - 0.45, -$radious + extra_heigt])
	    rotate([0,180,0])
	    cylinder(h=$radious * 2 + extra_heigt,r=$radious);
	}
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
	    mjf_supports(layout=layout,size=17.16, gen_support=gen_support)
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
	    mjf_supports(layout=layout,size=17.16, gen_support=gen_support)
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

row = is_undef(row) ? "r1" : row;

if (row == "r1") {
  translate([19, 0, 0])genside(R1);
  mirror([5*19, 0, 0]) genside(R1);
 }

if (row == "r2") {
  translate([19, 0, 0])genside(R2);
  mirror([5*19, 0, 0]) genside(R2);
 }

if (row == "r3") {
  translate([19, 0, 0])genside(R3);
  mirror([5*19, 0, 0]) genside(R3);
 }

if (row == "thumb") {
  translate([19, 0, 0])genside(Thumb);
  mirror([5*19, 0, 0]) genside(Thumb);
 }
