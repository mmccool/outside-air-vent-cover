// Outside Air Vent Cover
// Michael McCool 2020
sm = 10;
t = 0.01;

base_t = 5;
base_r = 3;
base_w = 118;
base_h = 170;
base_e = 1;
base_sm = 2*sm;

vent_r = 130 - base_h/2;
vent_sm = 5*sm;
vent_f = 0.3;
vent_d = -vent_r-t + 2*vent_f*vent_r;
vent_e = 3;
vent_s = 5;

hole_r = 2;
hole_R = 5;
hole_o = 15;
hole_sm = 3*sm;
hole_h1 = 1;
hole_h2 = hole_R+2;
hole_xo = 82/2;
hole_yo = 146/2;

cover_t = 2;
cover_r = hole_xo - hole_R - 5;
cover_R = vent_r + cover_t;
cover_h = base_h/2 + t;
cover_F = 0.6;
cover_sm = 5*sm;

rim_t = 10;
rim_e = 3;
rim_r = base_r - rim_e/2;

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

vent_g = 10;

module vent() {
  rotate(180) translate([0,0,-t])
    difference() {
      hull() {
        //cylinder(r=vent_r,h=base_t+2*t,$fn=vent_sm);
        translate([0,0,base_t])
          sphere(r=vent_r,$fn=vent_sm);
        translate([0,cover_h,base_t])
          //cylinder(r=cover_r-cover_t,h=base_t+2*t,$fn=vent_sm);
          sphere(r=cover_r-cover_t,$fn=vent_sm);
      }
      translate([-base_w/2-2*t,-base_h/2-2*t,cover_F*cover_R-2*cover_t+base_t])
        cube([base_w+4*t,base_h+4*t,base_t+cover_R]);
      translate([-base_w/2-2*t,base_h/2-vent_g,0])
        cube([base_w+4*t,base_h,base_t+cover_R]);
/*
      translate([-vent_r-2*t,vent_d,0])
        hull() {
          translate([0,0,-2*t])
            cube([2*vent_r+2*t,2*vent_r+2*t,base_e+2*t]);
          translate([0,vent_s,base_t-2*t])
            cube([2*vent_r+2*t,2*vent_r+2*t,base_e+2*t]);
        }
*/
    }
}

grill_r = 1;
grill_sm = sm;
module grill() {
  intersection() {
    union() {
      for (j = [0 : 3*grill_r : cover_F*cover_R-2*cover_t]) { 
        for (i = [-30*grill_r : 3*grill_r : 30*grill_r]) { 
          translate([i,0,j+2*grill_r])
            rotate([90,0,0]) 
              cylinder(r=grill_r,h=base_h,$fn=grill_sm);
        }
      }
    }
    translate([0,0,base_t-t]) union() {
      sphere(r=cover_R,$fn=cover_sm);
      rotate([90,0,0])
        cylinder(r=cover_r,h=cover_h+t,$fn=cover_sm);
    }
  }
}

module cover() {
  translate([0,0,base_t-t]) {
    difference() {
      hull() {
        difference() {
          union() {
            sphere(r=cover_R,$fn=cover_sm);
            rotate([90,0,0])
              cylinder(r=cover_r,h=cover_h,$fn=cover_sm);
          }
          translate([-base_w/2-2*t,-base_h/2-2*t,cover_F*cover_R])
            cube([base_w+4*t,base_h+4*t,base_t+cover_R]);
        }
        base();
      }
/*
      difference() {
        hull() {
          sphere(r=cover_R-cover_t,$fn=cover_sm);
          rotate([90,0,0])
            cylinder(r=cover_r-cover_t,h=cover_h+t,$fn=cover_sm);
        }
        translate([-base_w/2-2*t,-base_h/2-2*t,cover_F*cover_R-cover_t])
          cube([base_w+4*t,base_h+4*t,base_t+cover_R]);
      }
*/
      translate([-base_w/2-t,-base_h/2-2*t,-base_t-cover_R-t])
       cube([base_w+2*t,base_h+4*t,base_t+cover_R]);
    }
  }
}


module hole() {
  translate([0,-hole_o,-t])
    cylinder(r=hole_R,h=hole_h1+hole_h2+t,$fn=hole_sm);
  translate([0,0,-t]) 
      cylinder(r=hole_r,h=cover_R+cover_t,$fn=hole_sm);
  hull() {
    translate([0,0,-t]) 
      cylinder(r=hole_r,h=hole_h1+t,$fn=hole_sm);
    translate([0,-hole_o,-t]) 
      cylinder(r=hole_r,h=hole_h1+t,$fn=hole_sm);
  }
  translate([0,0,hole_h1])
    hull() {
      translate([0,0,hole_R-hole_r-t]) 
        cylinder(r=hole_R,h=hole_h2-hole_h1,$fn=hole_sm);
      translate([0,-hole_o,hole_R-hole_r-t]) 
        cylinder(r=hole_R,h=hole_h2-hole_h1,$fn=hole_sm);
      translate([0,0,-t]) 
        cylinder(r=hole_r,h=hole_h1+t,$fn=hole_sm);
      translate([0,-hole_o,-t]) 
        cylinder(r=hole_r,h=hole_h1+t,$fn=hole_sm);
    }
}

module assembly() {
  difference() {
    union() {
      base();
      rim();
      cover();
    }
    grill();
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