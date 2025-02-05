/*
// Simple DIY Electronic Music Projects
//    diyelectromusic.wordpress.com
//
// Raspberry Pi Cases
// https://diyelectromusic.com/2025/02/05/raspberry-pi-234-a-b-synth-cases/
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
show_board=1;
show_base=1;
show_top=1;
show_split=1;

// RPi form factor versions:
//   0 = 2,3 B+
//   1 = 4 B+
//   2 = A+
rpi=0;

show_cutouts=0;
gpiogap=0;
testbuild=0;

//
// Mechanical information for Raspberry Pi Boards:
//  https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#schematics-and-mechanical-drawings
//

boards = [
    [85, 56, 1.5],  // 2,3 B+
    [85, 56, 1.5],  // 4 B+
    [65, 56, 1.5],  // 1,3 A+
];

board = boards[rpi];

th = 2;
padxy = 1.5;
padbot = 3;
padtop = rpi==2 ? 13 : 21;  // A+ can be shorter
box = board + [th*2+padxy*2,th*2+padxy*2,th*2+padtop+padbot];
cornerrounding = 4;
split = 9;

// Relate to board coords not box
// So need to add th+padxy to x,y and th+padbot to z
mountholes = [
[3.5,    3.5,    0],
[3.5,    3.5+49, 0],
[3.5+58, 3.5+49, 0],
[3.5+58, 3.5,    0]
];
mounthole_d = 2.5;
standoff_d = 6.0;

// Position of lips for the case
//  [x, y, z, len, rotation] rot=0 in y direction
lips_a = [
  [0, th+padxy+2, split, box.y-2*(th+padxy+2), 0], // sd end
  [box.x-(th+padxy+2)-14, 0, split, 7, 90], // con side
  [th+padxy+2, box.y, split, box.x-2*(th+padxy+2), -90], // blank side
  [box.x, th+padxy+2+18, split, 18, 180],
  [box.x, box.y-(th+padxy+2), split, 11, 180],
];
lips_b = [
  [0, th+padxy+2, split, box.y-2*(th+padxy+2), 0], // sd end
  [box.x-th-padxy-2, 0, split, 20, 90], // con side
  [th+padxy+2, box.y, split, box.x-2*(th+padxy+2), -90], // blank side
  // No lip on eth/usb end for B+
];
lips = [lips_b,lips_b,lips_a];
lip  = lips[rpi];

// Device/connector cutouts
//   [position], [size], [hole adj], [size adj]
// Relates to board not box
// So need to add th+padxy to x,y and th+padbot+board.z to z
gpio    = [[ 7.2,50.0, 0.0],[50.0, 5.1, 9.0],[ 0.0, 0.0, 0.0],[ 0.0, 0.0, 0.0]];
ethusb  = [[65.5, 2.0, 0.0],[21.2,52.0,16.0],[ 0.0,-2.0, 0.0],[ 5.0, 4.0, 0.0]];
micro   = [[ 6.5,-1.5, 0.0],[ 8.0, 6.0, 3.0],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 1.0]];
micro_e = [[ 6.5,-1.5, 0.0],[ 8.0, 6.0, 3.0],[-3.0,-2.5,-1.0],[ 6.0,-4.5, 3.0]];
hdmi    = [[24.4,-2.0, 0.0],[15.2,12.0, 7.9],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 0.0]];
sd      = [[-3.0,19.5,-4.0],[14.0,17.0, 2.5],[-3.0, 0.0,-3.0],[-7.0, 0.0, 4.0]];
audio   = [[50.4,-2.0, 0.0],[ 6.2,14.5, 6.4],[ 0.0,-4.0, 0.0],[ 0.0, 4.0, 0.0]];
usbc    = [[ 6.7,-1.2, 0.1],[ 9.0, 7.3, 3.2],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 1.0]];
usbc_e  = [[ 6.7,-1.2, 0.1],[ 9.0, 7.3, 3.2],[-2.5,-2.5,-1.0],[32.5,-6.0, 3.0]];
mhdmi1  = [[22.3, 0.0, 0.0],[ 7.4, 8.2, 3.3],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 0.0]];
mhdmi2  = [[35.8, 0.0, 0.0],[ 7.4, 8.2, 3.3],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 0.0]];
usb_a   = [[53.0,23.8, 0.0],[14.0,15.4, 7.5],[ 0.0,-0.5, 0.0],[ 5.0, 1.0, 0.5]];

dev = [
    [gpio,ethusb,micro,hdmi,sd,audio],          // 2,3 B+
    [gpio,ethusb,usbc,mhdmi1,mhdmi2,sd,audio],  // 4 B+
    [gpio,micro,hdmi,sd,audio,usb_a],           // A+
];

dev_e = [
    [micro_e],  // 2,3 B+
    [usbc_e],   // 4 B+
    [micro_e],  // A+
];

// Devices on the board
devices = dev[rpi];
// Additional cutouts
extras = dev_e[rpi];

if (show_cutouts) {
    translate([th+padxy, th+padxy, th+padbot+board.z]) {
      color("Purple") {
          for (td=devices) {
            translate(td[0]+td[2]) cube(td[1]+td[3]);
          }
      }
    }
}

// Board
if (show_board) {
    translate([th+padxy, th+padxy, th+padbot]) {
        color("green") cube(board);
        color("silver") {
            for (d=devices) {
                translate(d[0]+[0,0,board.z]) cube(d[1]);
            }
        }
    }
}

// Bottom
//difference() { union() {
if (show_base) {
    build_base();
}
//} translate([10,11,-1]) cube([74,42,10]); }

// Top
//difference() { union() {
if (show_top) {
    if (show_split) {
        translate([box[0],100,box[2]-split]) {
            rotate([0,180,0]) {
                translate([0,0,-split]) {
                    build_top();
                }
            }
        }
    } else {
        build_top();
    }
}
//} translate([10,111,-1]) cube([74,42,10]); }

module build_base () {
    difference() {
        union () {
            intersection() {
                cube([100,100,split]);
                case();
            }
            
            // Add lips to the base
            build_lips(true);
        }

        // If building for a test, remove bulk
        if (testbuild) {
            translate([10,10,-1]) cube(box-[20,20,0]);
        }
    }
}

module build_top () {
    difference () {
        intersection() {
            translate([0,0,split]) cube([100,100,box[2]-split]);
            case();
        }
        
        union () {            
            // Take lips off the top
            build_lips(false);
            
            // And opitonally GPIO
            if (gpiogap) {
                translate(gpio[0]) cube(gpio[1]+[0,0,box.z]);
            }
            
            // If building for a test, remove bulk
            if (testbuild) {
                translate([10,10,1]) cube(box-[20,20,0]);
            }
        }
    }

    // Add clamps for the standoffs
    for (m=mountholes) {
        addclamp(m+[th+padxy,th+padxy,th+padbot+board.z], standoff_d, padtop);
    }

}

module case () {
    difference () {
        outerbox (box, cornerrounding, th);
        cutouts();
    }
    
    for (m=mountholes) {
        standoff(m+[th+padxy,th+padxy,th], standoff_d, padbot);
    }
}

module outerbox(box,r,th){
    //spheres at the corners of a box and run hull over it
    out = box  - 2 * [r,r,r];
    in = box  - 2 * [r,r,r] - [th*2,th*2,th*2];
    rad=[r,r,r];
    difference(){
        hull(){
            translate(rad+[0,0,0]) sphere(r);
            translate(rad+[0,0,out[2]]) sphere(r);
            translate(rad+[0,out[1],0]) sphere(r);
            translate(rad+[0,out[1],out[2]]) sphere(r);
            translate(rad+[out[0],0,0]) sphere(r);
            translate(rad+[out[0],0,out[2]]) sphere(r);
            translate(rad+[out[0],out[1],0]) sphere(r);
            translate(rad+[out[0],out[1],out[2]]) sphere(r);
        }
        hull(){
            translate([th,th,th]) {
                translate(rad+[0,0,0]) sphere(r);
                translate(rad+[0,0,in[2]]) sphere(r);
                translate(rad+[0,in[1],0]) sphere(r);
                translate(rad+[0,in[1],in[2]]) sphere(r);
                translate(rad+[in[0],0,0]) sphere(r);
                translate(rad+[in[0],0,in[2]]) sphere(r);
                translate(rad+[in[0],in[1],0]) sphere(r);
                translate(rad+[in[0],in[1],in[2]]) sphere(r);
            }
        }
    }
}

module standoff (so, d, h) {
    translate([so.x, so.y, so.z])
        cylinder(d=d, h=h, $fn=10);

    translate([so.x, so.y, so.z+h])
        cylinder(d=mounthole_d, h=board.z, $fn=10);

    translate([so.x, so.y, so.z+h+board.z])
        sphere(d=mounthole_d, $fn=10);
}

module addclamp (so, d, h) {
    translate([so.x, so.y, so.z]) {
        difference() {
            cylinder(d=d, h=h, $fn=10);
            translate([0,0,-0.1])
                cylinder(d=mounthole_d, h=3, $fn=10);
        }
    }
}

module cutouts() {
    translate([th+padxy, th+padxy, th+padbot+board.z]) {
        for (d=devices) {
            translate(d[0]+d[2]) cube(d[1]+d[3]);
        }
        for (e=extras) {
            translate(e[0]+e[2]) cube(e[1]+e[3]);
        }
    }
}

module build_lips(solid) {
    for (l=lip) {
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
