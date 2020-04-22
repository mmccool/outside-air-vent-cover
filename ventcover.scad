// Outside Air Vent Cover
// Michael McCool 2020
sm = 30;
t = 0.01;

// print scale correction
sc = true;
sx = sc ? 0.97*15.2/15.6 : 1.0;
sy = sc ? 0.97*15.2/15.6 : 1.0;
sz = sc ? 15.2/14 : 1.0;

base_t = 5;
base_r = 3;
base_w = 125;
base_h = 175;
base_e = 1;
base_sm = 2*sm;

vent_r = 130 - base_h/2;
vent_sm = 5*sm;
vent_f = 0.3;
vent_d = -vent_r-t + 2*vent_f*vent_r;
vent_e = 3;
vent_s = 5;

hole_r = 2;
hole_R = 7;
hole_b = hole_R;
hole_o = 15;
hole_sm = 3*sm;
hole_h1 = 1;
hole_h2 = 3;
hole_xo = 81/2;
hole_yo = 146/2;

cover_t = 5;
cover_r = hole_xo - hole_R - 5;
cover_R = vent_r + cover_t;
cover_h = base_h/2 + t;
cover_F = 0.7;
cover_sm = 5*sm;

rim_t = 15;
rim_a = 8.5;
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
      translate([0,0,0])
        rotate([-rim_a,0,0]) 
          translate([-base_w/2-t,5-base_h/2-7,-2*rim_t])
            cube([base_w+2*t,base_h/2+20,2*rim_t]);
      translate([0,base_h/2,0]) 
        rotate([-rim_a,0,0]) 
          translate([-base_w/2-t,5-base_h/2-3,-2*rim_t])
            cube([base_w+2*t,base_h/2+10,2*rim_t]);
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

grill_r = 1.8;
grill_s = 0.8*grill_r;
grill_o = 0.5*grill_r;
grill_sm = 6; // sm;
module grill() {
  intersection() {
    union() {
      s = sin(60)*3*grill_s;
      for (jj = [0 : 1 : (cover_F*cover_R-2*cover_t)/s]) { 
        oo = (jj % 2 == 0) ? 0 : 0*1.5*grill_s;
        j = jj*s;
        for (ii = [-6+jj/2 : 1 : 6-jj/2]) { 
          i = ii*3*grill_s;
          translate([i+oo,0,j+2*grill_s+grill_o])
            rotate([90,0,0]) 
              translate([0,0,cover_R])
                rotate(30) 
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

cover_c = 2*base_r;
module cover() {
  translate([0,0,base_t-t]) {
    difference() {
      hull() {
/*
        difference() {
          union() {
            sphere(r=cover_R,$fn=cover_sm);
            rotate([90,0,0])
              cylinder(r=cover_r,h=cover_h,$fn=cover_sm);
          }
          translate([-base_w/2-2*t,-base_h/2-2*t,cover_F*cover_R])
            cube([base_w+4*t,base_h+4*t,base_t+cover_R]);
        }
*/
        translate([0,0,cover_F*cover_R-base_t-t]) hull() {
          translate([-base_w/2+base_r+cover_c,-base_h/2+base_r+cover_c,0])
            cylinder(r=base_r,h=t,$fn=base_sm);
          translate([ base_w/2-base_r-cover_c,-base_h/2+base_r+cover_c,0])
            cylinder(r=base_r,h=t,$fn=base_sm);
          translate([-base_w/2+base_r+cover_c, base_h/2-base_r-cover_c,0])
            cylinder(r=base_r,h=t,$fn=base_sm);
          translate([ base_w/2-base_r-cover_c, base_h/2-base_r-cover_c,0])
            cylinder(r=base_r,h=t,$fn=base_sm);
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
    cylinder(r=hole_R,h=hole_R+t,$fn=hole_sm);
  hull() {
    translate([0,0,hole_R+t]) 
      // cylinder(r1=hole_b,r2=hole_r,h=cover_F*cover_R-hole_R,$fn=hole_sm);
      cylinder(r=hole_b,h=cover_F*cover_R-hole_R,$fn=hole_sm);
    translate([0,-hole_o,hole_R+t]) 
      // cylinder(r1=hole_b,r2=hole_r,h=cover_F*cover_R-hole_R,$fn=hole_sm);
      cylinder(r=hole_b,h=cover_F*cover_R-hole_R,$fn=hole_sm);
  }
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

ridge_r = 2;
ridge_h = 4*ridge_r+base_w/(2*cos(45));
ridge_sm = 6;
ridge_eps = 0.00001;
module half_ridges(a=0) {
  for (dy = [-base_h/2 : 5*ridge_r : 3*base_h/4]) {
    translate([0,dy+3,cover_F*cover_R])
      rotate([0,0,a-45])
        rotate([0,90,0])
          translate([0,0,-2*ridge_r])
            rotate([0,0,30])
              cylinder(r=ridge_r,h=ridge_h,$fn=ridge_sm);
  }
}
module ridges() {
  intersection() {
    half_ridges(0);
    translate([-ridge_eps,-base_h/2-1,-1])
      cube([base_w/2+ridge_eps+1,base_h+2,cover_F*cover_R+2*ridge_r+1]);
  }
  intersection() {
    half_ridges(270);
    translate([-base_w/2-1+ridge_eps,-base_h/2-1,-1])
      cube([base_w/2+ridge_eps+1,base_h+2,cover_F*cover_R+2*ridge_r+1]);
  }
}

module assembly() {
  difference() {
    union() {
      base();
      rim();
      cover();
    }
    color([1,0,0]) ridges();
    color([0,1,0]) grill();
    color([0,0,1]) vent();
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
//assembly();
module assembly_cutaway() {
  intersection() {
    assembly();
    translate([-base_w/2-1+ridge_eps,0,-1])
      cube([base_w/2+ridge_eps+1,base_h+2,cover_F*cover_R+2*ridge_r+1]);
  }
}
//assembly_cutaway();

// PRINT
module print_assembly() {
  scale([sx,sy,sz]) 
    rotate([0,180,90])
      assembly();
}
print_assembly();