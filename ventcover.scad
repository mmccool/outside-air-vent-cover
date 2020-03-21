// Outside Air Vent Cover
// Michael McCool 2020
sm = 10;
t = 0.01;

base_t = 5;
base_r = 3;
base_w = 100;
base_h = 130;
base_sm = 2*sm;

vent_r = 18;
vent_sm = 5*sm;
vent_f = 0.3;
vent_d = -vent_r-t + 2*vent_f*vent_r;
vent_e = 3;
vent_s = 5;

cover_t = 1;
cover_r = vent_r + cover_t - 4;
cover_R = vent_r + cover_t;
cover_h = base_h/2 - 5;
cover_sm = 5*sm;

module base() {
  hull() {
    translate([-base_w/2+base_r,-base_h/2+base_r,0])
      cylinder(r=base_r,h=base_t,$fn=base_sm);
    translate([ base_w/2-base_r,-base_h/2+base_r,0])
      cylinder(r=base_r,h=base_t,$fn=base_sm);
    translate([-base_w/2+base_r, base_h/2-base_r,0])
      cylinder(r=base_r,h=base_t,$fn=base_sm);
    translate([ base_w/2-base_r, base_h/2-base_r,0])
      cylinder(r=base_r,h=base_t,$fn=base_sm);
  }
}

rim_t = 10;
rim_e = 3;
rim_r = base_r - rim_e/2;
module rim() {
  translate([0,0,-rim_t])
    difference() {
      hull() {
        translate([-base_w/2+base_r,-base_h/2+base_r,0])
          cylinder(r=base_r,h=rim_t+t,$fn=base_sm);
        translate([ base_w/2-base_r,-base_h/2+base_r,0])
          cylinder(r=base_r,h=rim_t+t,$fn=base_sm);
        translate([-base_w/2+base_r, base_h/2-base_r,0])
          cylinder(r=base_r,h=rim_t+t,$fn=base_sm);
        translate([ base_w/2-base_r, base_h/2-base_r,0])
          cylinder(r=base_r,h=rim_t+t,$fn=base_sm);
      }
      hull() {
        translate([-base_w/2+rim_r+rim_e,-base_h/2-rim_r,-t])
          cylinder(r=rim_r,h=rim_t+3*t,$fn=base_sm);
        translate([ base_w/2-rim_r-rim_e,-base_h/2-rim_r,-t])
          cylinder(r=rim_r,h=rim_t+3*t,$fn=base_sm);
        translate([-base_w/2+rim_r+rim_e, base_h/2-rim_r-rim_e,-t])
          cylinder(r=rim_r,h=rim_t+3*t,$fn=base_sm);
        translate([ base_w/2-rim_r-rim_e, base_h/2-rim_r-rim_e,-t])
          cylinder(r=rim_r,h=rim_t+3*t,$fn=base_sm);
      }
    }
}

module vent() {
  rotate(180) translate([0,0,-t])
    difference() {
      cylinder(r=vent_r,base_t+2*t,$fn=vent_sm);
      translate([-vent_r-2*t,vent_d,0])
        hull() {
          translate([0,0,-2*t])
            cube([2*vent_r+2*t,2*vent_r+2*t,base_e+2*t]);
          translate([0,vent_s,base_t-2*t])
            cube([2*vent_r+2*t,2*vent_r+2*t,base_e+2*t]);
        }
    }
}

module cover() {
  translate([0,0,base_t-t]) {
    difference() {
      hull() {
        sphere(r=cover_R,$fn=cover_sm);
        rotate([90,0,0])
          cylinder(r=cover_r,h=cover_h,$fn=cover_sm);
      }
      hull() {
        sphere(r=cover_R-cover_t,$fn=cover_sm);
        rotate([90,0,0])
          cylinder(r=cover_r-cover_t,h=cover_h+t,$fn=cover_sm);
      }
      translate([-base_w/2-t,-base_h/2-t,-base_t-cover_r-t])
       cube([base_w+2*t,base_h+2*t,base_t+cover_r]);
    }
  }
}

hole_r = 2;
hole_R = 5;
hole_o = 15;
hole_sm = 3*sm;
hole_h1 = 1;
hole_h2 = 2*base_t;
hole_xo = 25;
hole_yo = 40;
module hole() {
  translate([0,-hole_o,-t])
    cylinder(r=hole_R,h=hole_h1+t,$fn=hole_sm);
  hull() {
    translate([0,0,-t]) 
      cylinder(r=hole_r,h=hole_h1+t,$fn=hole_sm);
    translate([0,-hole_o,-t]) 
      cylinder(r=hole_r,h=hole_h1+t,$fn=hole_sm);
  }
  translate([0,0,hole_h1])
    hull() {
      translate([0,0,-t]) 
        cylinder(r=hole_R,h=hole_h2,$fn=hole_sm);
      translate([0,-hole_o,-t]) 
        cylinder(r=hole_R,h=hole_h2,$fn=hole_sm);
    }
}

module assembly() {
  difference() {
    union() {
      base();
      rim();
      cover();
    }
    vent();
    translate([hole_xo,hole_yo,0]) hole();
    translate([-hole_xo,hole_yo,0]) hole();
    translate([hole_xo,-hole_yo,0]) hole();
    translate([-hole_xo,-hole_yo,0]) hole();
  }
}

//base();
//vent();
//cover();
//hole();
assembly();