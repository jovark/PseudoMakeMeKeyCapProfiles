use <so3.scad>

function val(a=undef,default=undef) = a == undef ? default : a;
function vec_is_undef(x,index_=0) = index_ >= len(x) ? true :
is_undef(x[index_]) && vec_is_undef(x,index_+1);

// Either a or b, but not both
function either(a,b,default=undef) = is_undef(a) ? (is_undef(b) ? default : b) : is_undef(b) ? a : undef;

function translationv(left=undef,right=undef,up=undef,down=undef,forward=undef,backward=undef,translation=undef) = 
translationv_2(
	x = is_undef(down) ? up : either(up,-down),
	y = is_undef(left) ? right : either(right,-left),
	z = is_undef(backward) ? forward : either(forward,-backward),
	translation = translation);

function translationv_2(x,y,z,translation) =
	x == undef && y == undef && z == undef ? translation :
	is_undef(translation) ? [val(x,0),val(y,0),val(z,0)]
	: undef;

function rotationv(pitch=undef,yaw=undef,roll=undef,rotation=undef) = 
	rotation == undef ? [val(yaw,0),val(pitch,0),val(roll,0)] :
	pitch == undef && yaw == undef && roll == undef ? rotation :
	undef;

function trajectory(
	left=undef,    right=undef,
	up=undef,      down=undef,
	forward=undef, backward=undef,
	translation=undef,

    pitch=undef,
    yaw=undef,
    roll=undef,
    rotation=undef
) = concat(
	translationv(left=left,right=right,up=up,down=down,forward=forward,backward=backward,translation=translation),
	rotationv(pitch=pitch,yaw=yaw,roll=roll,rotation=rotation)
);

function rotationm(rotation=undef,pitch=undef,yaw=undef,roll=undef) = so3_exp(rotationv(rotation=rotation,pitch=pitch,yaw=yaw,roll=roll));
