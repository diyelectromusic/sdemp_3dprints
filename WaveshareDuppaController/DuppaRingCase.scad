/*
// Simple DIY Electronic Music Projects
//    diyelectromusic.wordpress.com
//
// Duppa Ring Case
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

show_split=1;

tol=0.5;    // Tolerance either side of the PCB
pcbw=40;    // Actual width of the PCB
pcbl=40;    // Actual length of the PCB
pcbth=1.6;  // Thickness of the PCB
pcbh1=16;   // Height of PCB above base
pcbh2=10.5;   // Height of LED PCB above PCB
pcbr=2.5;     // Radius of curve of corners of PCB
th=1.5;     // Thickness of case sides and base

ledr=15;

split=pcbh1+th+pcbth;

// box starts at [0,0,0]
pcbx=th+tol; // Start X coord of actual PCB
pcby=th+tol; // Start Y coord of actual PCB

// box dim = pcb dim + thickness and tolerance
boxw=pcbw+th*2+tol*2;
boxl=pcbl+th*2+tol*2;

// box height is thickness of base/top + PCB thickness + PCB height(s) + bit extra
boxh=th+pcbh1+pcbth+pcbh2+pcbth+th+2;

// Box corner radius = pcb corner radius + tol + thickness of sides
boxr=pcbr+th+tol;

// PCB mount hole dimensions
pcbhole=4;            // X/Y offset from corner of PCB
mounthole=2;          // Radius of mounting point hole
mounthole_h=6;        // Depth of mounting point hole
mountsupport=4;       // Radius of support
mountsupport_h=pcbh1-10; // Height of support = height of PCB - height of standoffs

// Convenience value = offset to mounting point centre from box external
mo=pcbhole+th+tol;

// Cutouts for the case
// [position][dimensions][circle]
trsh = th+pcbh1+pcbth;
usbh = 4;
usbz = th+pcbh1-13;
pot  = [[boxw/2,boxl/2,boxh-3],    [7,7,7],1];
pot2 = [[boxw/2,boxl/2,boxh-2],    [10,10,1],1];
trs  = [[boxw-3,-3.5+boxl/2,trsh], [7,7,7],0];
trs2 = [[boxw-3,-6+boxl/2,trsh],   [2.3,12,7],0];
usb  = [[-5.0+boxw/2,boxl-2,usbz], [10,3,split-usbz],0];
usb2 = [[-8.0+boxw/2,boxl-0.7,usbz-1], [16,3,usbh+2],0];

cutouts = [pot,pot2,trs,trs2,usb,usb2];

// Extra to add to backfill USB from split
usb_e = [[-4.6+boxw/2,boxl-th,usbz+usbh],[9.8,th,split-usbz-usbh]];
extras = [usb_e];

// Define lips for the case
//  [x, y, z, len, rotation] rot=0 in y direction
lips = [
  [boxw-6, 0, split, boxw-12, 90],
  [0, 6, split, boxl-12, 0],
  [6, boxl, split, 10, 270],
  [boxw-6-10, boxl, split, 10, 270],
  [boxw, boxl-6, split, 10, 180],
  [boxw, 6+10, split, 10, 180],
];

box_base();
if (show_split) {
    translate([boxw,boxl+20,boxh-split]) {
        rotate([0,180,0]) {
            translate([0,0,-split]) {
                box_top();
            }
        }
    }
} else {
    box_top();
}

standoff([mo,mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);
standoff([boxw-mo,mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);
standoff([mo,boxl-mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);
standoff([boxw-mo,boxl-mo,th],mountsupport,mountsupport_h,mounthole,mounthole_h);


module box_base () {
    difference() {
        union () {
            intersection() {
                cube([100,100,split]);
                box();
            }
            
            // Add lips to the base
            build_lips(true);
        }
    }
}

module box_top() {
    difference () {
        union() {
            intersection() {
                translate([0,0,split]) cube([100,100,boxh-split]);
                    box();
            }
            for (c=extras) {
                translate(c[0]) cube(c[1]);
            }
        }
        
        // Take lips off the top
        build_lips(false);
    }
}

module box() {
    difference() {
        union() {
            base();
            top();
        }
        // cutouts
        union() {
            for (c=cutouts) {
                if (c[2]) {
                    translate(c[0]) cylinder(h=c[1].z,d=c[1].x, $fn=40);
                } else {
                    translate(c[0]) cube(c[1]);
                }
            }
        }
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

module top() {
    translate([0,0,boxh-th]) {
        difference() {
            rounded([boxw,boxl,th],boxr);
            translate([boxw/2,boxl/2,-0.1]) {
                for (a = [0: 360/24: 360]) {
                    translate([ledr*sin(a),ledr*cos(a),0]) {
                        cylinder(h=th+0.2, r=1.2, $fn=50);
                    }
                }
            }
        }
    }
}

module build_lips(solid) {
    for (l=lips) {
        translate([l[0],l[1],l[2]]) {
            rotate([0,0,l[4]]) {
                if (solid) {
                    build_lip (l[3]);
                } else {
                    // If printing the gap/hole side, allow a little extra
                    translate([0,-0.2,0])
                        build_lip (l[3]+0.4);
                }
            }
        }
    }
}

module build_lip (len) {
    ovl = 0.2;
    
    // Create a rectangle and two squashed circle profile
    // in the vertical plane and stretch accordingly
    translate([0.1, len, -0.01]) {
        rotate([90, 0, 0]) {
            linear_extrude(len) {
                difference() {
                    // Main rectangle
                    translate([th*0.5, 0])
                        square([th*0.5, th]);

                    // inny bit
                    translate([th*0.5, th*0.25])
                        scale([ovl, 1])
                            circle(d=th*0.5, $fn=10);
                }
                // outy bit
                translate([th*0.5, th*0.75])
                    scale([ovl, 1])
                        circle(d=th*0.5, $fn=10);
            }
        }
    }
}

module standoff(pos,r,h,hr,hh) {
    translate(pos) {
        difference() {
            cylinder(h=h, r=r, $fn=20);
            translate([0,0,h-hh]) {
                cylinder(h=hh+0.2, r=hr, $fn=20);
            }
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