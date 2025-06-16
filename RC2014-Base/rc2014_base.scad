/*
// Simple DIY Electronic Music Projects
//    diyelectromusic.wordpress.com
//
// RC2014 Base plate
//
      MIT License
      
      Copyright (c) 2025 diyelectromusic (Kevin)
      
      Permission is hereby granted, free of charge, to any person obtaining a copy of
      this software and associated documentation files (the "Software"), to deal in
      the Software without restriction, including without limitation the rights to
      use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
      the Software, and to permit persons to whom the Software is furnished to do so,
      subject to the following conditions:
      
      The above copyright notice and this permission notice shall be included in all
      copies or substantial portions of the Software.
      
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
      FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
      COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHERIN
      AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
      WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
//
//    +----B------------+
//    +                 +
//    + | | | | | | | | +
//    + | | | | | | | | +
//    + | | | | | | | | +
//    + | | | | | | | | +
//    +   rc2014 base   +
//    +-----------------+
//  ^
//  |
//  y=L  x=W->
//

// Which baseplate to build
//   0 = base 5
//   1 = base 8
rc2014 = 1;

widths=[70, 127]; // Base5, Base8 pcb widths in mm

tol=0.5;    // Tolerance either side of the PCB
pcbw=widths[rc2014];   // Actual width of the PCB
pcbl=127;   // Actual length of the PCB
pcbth=1.6;  // Thickness of the PCB
pcbh=3;     // Height of PCB above base
pcbr=5;     // Radius of curve of corners of PCB
th=1.5;     // Thickness of case sides and base

// box starts at [0,0,0]
pcbx=th+tol; // Start X coord of actual PCB
pcby=th+tol; // Start Y coord of actual PCB

// box dim = pcb dim + thickness and tolerance
boxw=pcbw+th*2+tol*2;
boxl=pcbl+th*2+tol*2;

// box height is thickness of base + PCB thickness + PCB height + bit extra
boxh=th+pcbh+pcbth+2;

// Box corner radius = pcb corner radius + tol + thickness of sides
boxr=pcbr+th+tol;

// PCB mount hole dimensions
pcbhole=6;           // X/Y offset from corner of PCB
mounthole=1.5;       // Radius of mounting point = hole radius less a tolerance
mounthole_h=pcbth+1;   // Height of mounting point (plus bit extra due to dome shape)
mountsupport=3;      // Radius of support
mountsupport_h=pcbh; // Height of support = height of PCB

// PCB long supports
pcbsupw = 5.5;
pcbsupl = 100;

// Convenience value = offset to mounting point centre from box external
mo=pcbhole+th+tol;

difference() {
union() {
    difference() {
        difference() {
            base();
        }
        // cutout for power socket
        translate([43+pcbx,boxl-5,th+pcbh+pcbth])
            cube([10,10,10]);
    }

    standoff([mo,mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);
    standoff([boxw-mo,mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);
    standoff([mo,boxl-mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);
    standoff([boxw-mo,boxl-mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);

    translate([pcbx,pcby,th]) {
        if (rc2014==1) { // Base 8
            pcbsupport([12,12,0]);
            pcbsupport([44,12,0]);
            pcbsupport([79,12,0]);
            pcbsupport([111,12,0]);
        }
        if (rc2014==0) { // Base 5
            pcbsupport([11,12,0]);
            pcbsupport([59-pcbsupw,12,0]);
        }
    }
}
// Test cutout
union() {
/*    translate([mo+mountsupport,mo+mountsupport,-0.1])
        cube([boxw-2*(mo+mountsupport),boxl-2*(mo+mountsupport),boxh+0.2]);*/
/*    translate([-0.1,-25,-0.1])
        cube([boxw+0.2,boxl,20]);
    translate([22,0,-0.1]) cube([21,125,4]);
    translate([54,0,-0.1]) cube([24,125,4]);
    translate([89,0,-0.1]) cube([21,125,4]);*/
}
}

module base() {
    difference() {
        // Outside
        intersection() {
            cube([boxw,boxl,boxh]);
            rounded([boxw,boxl,boxh*2],boxr);
        }
        // Inside
        translate([th,th,th]) {
            intersection() {
                cube([pcbw+tol*2,pcbl+tol*2,boxh]);
                rounded([pcbw+tol*2,pcbl+tol*2,boxh*2-th*2],pcbr+tol);
            }
        }
    }
}

module pcbsupport(pos) {
    translate(pos) {
        cube([pcbsupw,pcbsupl,pcbh]);
    }
}

module standoff(pos,r,h,hr,hh) {
    translate(pos) {
        // post
        cylinder(h=h, r=r, $fn=20);
        translate([0,0,h]) {
            // mounting
            cylinder(h=hh, r=hr, $fn=20);
            translate([0,0,hh])
                sphere(r=hr, $fn=20);
        }
    }
}

module rounded(size, radius) {
	translate ([radius, radius, 0]) {
        minkowski() {
            cube([size[0]-(radius * 2), size[1]-(radius * 2), size[2]]);
            cylinder(r=radius, h=size[2], $fn=20);
        }
    }
}