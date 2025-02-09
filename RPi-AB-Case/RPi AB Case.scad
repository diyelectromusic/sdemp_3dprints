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
show_board=0;
show_base=1;
show_top=1;
show_split=1;

// RPi form factor versions:
//   0 = 2,3 B+
//   1 = 4 B+
//   2 = A+
//   3 = Zero
rpi=0;

// Options
addvents=0;
gpiogap=0;

// Debug
show_cutouts=0;
testbuild=0;

// Advanced options
split = 9;

////////////////////////////////////////////////////////////////////
//
// Custom additional boards/cutouts can be added here
//
////////////////////////////////////////////////////////////////////

// If there are options, we can use the same pattern as for the Pi
mdopt = 0;

// Mechanical detail of add-on board
md_boards = [
[0,0,0]
];
md_board = md_boards[mdopt];

// Device/connector cutouts
//   [position], [size], [hole adj], [size adj], shape
//
// Shapes: 0=cube, 1=cylinder (circular in x-y plane)
//
// Relates to board not box
// So need to add th+padxy to x,y and th+padbot+board.z to z
md_gpio    = [[ 7.2,50.0, 0.0],[51.0, 5.1, 9.0],[ 0.0, 0.0, 0.0],[ 0.0, 0.0, 0.0],0];
md_gpio_e  = [[ 7.2,50.0, 0.0],[51.0, 5.1, 9.0],[ 0.0, 0.0, 0.0],[ 0.0, 0.0, 0.0],0];

// List all device/connector cutouts per add-on board
md_dev = [
//[md_gpio],  // Board option 0
];
// Additional cut-outs
md_dev_e = [
//[md_gpio_e],  // Board option 0
];

// Devices on the board
md_devices = md_dev[mdopt];
md_extras  = md_dev_e[mdopt];

// Other parameters for the add-on board.
// Leave padbot/top as zero if no additional boards.
md_padxy  = 1.5;
md_padbot = 0;  // height of MD board above RPi board
md_padtop = 0;  // height above MD board

//
// Following functions plug into the main construction and
// probably won't need updating once the above parameters
// are all setup properly for the custom board.
//

// Function to colour in the additional cutouts if present
module md_show_cutouts() {
    translate([th+padxy, th+padxy, th+padbot+board.z+md_padbot+md_board.z]) {
      color("Purple") {
          for (mtd=md_devices) {
            translate(mtd[0]+mtd[2]) {
                if (mtd[4] == 1) {
                    cylinder(h=mtd[1].z+mtd[3].z, d=mtd[1].x+mtd[3].x, $fn=10);
                } else {
                    cube(mtd[1]+mtd[3]);
                }
            }
          }
      }
    }
}

// Function to show the additional board
module md_show_board () {
    translate([th+padxy, th+padxy, th+padbot+board.z+md_padbot]) {
        color("green") cube(md_board);
        color("silver") {
            for (mdd=md_devices) {
                translate(mdd[0]+[0,0,md_board.z]) cube(mdd[1]);
            }
        }
    }
}

// Function to add in the additional cutouts if present
module md_cutouts () {
    translate([0, 0, md_padbot+md_board.z]) {
        for (mdd=md_devices) {
            translate(mdd[0]+mdd[2]) {
                if (mdd[4] == 1) {
                    cylinder(h=mdd[1].z+mdd[3].z, d=mdd[1].x+mdd[3].x, $fn=10);
                } else {
                    cube(mdd[1]+mdd[3]);
                }
            }
        }
        for (mde=md_extras) {
            translate(mde[0]+mde[2]) cube(mde[1]+mde[3]);
        }
    }
}

////////////////////////////////////////////////////////////////////
//
// End of custom additional boards/cutouts
//
////////////////////////////////////////////////////////////////////

//
// Mechanical information for Raspberry Pi Boards:
//  https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#schematics-and-mechanical-drawings
//

boards = [
    [85, 56, 1.5],  // 2,3 B+
    [85, 56, 1.5],  // 4 B+
    [65, 56, 1.5],  // 1,3 A+
    [65, 30, 1.5],  // Zero
];

board = boards[rpi];

// Space above the board
// Note: A+/Zero can be shorter
toppadding = [ 21, 21, 13, 13 ];

th = 2;
padxy = 1.5;
padbot = 3;
// If there is a custom add-on board, then use that paddtop value here
// Assumes that original padtop value is accounted for in the custom
// board's md_padbot value...
padtop = md_padtop > 0 ? md_padtop : toppadding[rpi];
box = board + [th*2+padxy*2,th*2+padxy*2,th*2+padtop+padbot+md_padbot+md_board.z];
cornerrounding = 4;

// Relate to board coords not box
// So need to add th+padxy to x,y and th+padbot to z
mh = [   // A+/B_
[3.5,    3.5,    0],
[3.5,    3.5+49, 0],
[3.5+58, 3.5+49, 0],
[3.5+58, 3.5,    0]
];
mh_z = [  // Zero
[3.5,    3.5,    0],
[3.5,    3.5+23, 0],
[3.5+58, 3.5+23, 0],
[3.5+58, 3.5,    0]
];
mounthole_d = 2.5;
standoff_d = 6.0;
clamphole_d = 3.0;
mountholes = [mh, mh, mh, mh_z];

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
lips_z = [
  [0, 5, split, 6, 0], // SD side
  [36, 0, split, 8.5, 90], // con side
  [box.x, box.y-(th+padxy+2), split, box.y-2*(th+padxy+2), 180], // short side
  [th+padxy+2, box.y, split, box.x-2*(th+padxy+2), -90], // long side
];
lips = [lips_b,lips_b,lips_a,lips_z];
lip  = lips[rpi];

// Device/connector cutouts
//   [position], [size], [hole adj], [size adj]
// Relates to board not box
// So need to add th+padxy to x,y and th+padbot+board.z to z
gpio    = [[ 7.2,50.0, 0.0],[51.0, 5.1, 9.0],[ 0.0, 0.0, 0.0],[ 0.0, 0.0, 0.0]];
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
gpio_z  = [[ 7.2,24.0, 0.0],[51.0, 5.1, 9.0],[ 0.0, 0.0, 0.0],[ 0.0, 0.0, 0.0]];
sd_z    = [[-3.0,11.0, 0.0],[16.0,12.0, 2.5],[-3.0,-1.0,-1.5],[-7.0, 2.0, 2.5]];
sd_ze   = [[-3.0,11.0, 0.0],[16.0,12.0, 2.5],[-13.5, -1.0,-6.0],[ 0.0, 2.0, 9.0]];
hdmi_z  = [[ 6.4,-1.0, 0.0],[12.0, 8.5, 4.0],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 0.0]];
hdmi_ze = [[ 6.4,-1.0, 0.0],[12.0, 8.5, 4.0],[-4.0,-10, -2.0],[ 8.0, 0.0, 4.0]];
uusb_d  = [[37.9,-1.0, 0.0],[ 7.0, 6.0, 3.0],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 0.0]];
uusb_p  = [[50.5,-1.0, 0.0],[ 7.0, 6.0, 3.0],[-1.0,-4.0, 0.0],[ 2.0, 4.0, 0.0]];
uusb_e  = [[37.9,-1.0, 0.0],[ 7.0, 6.0, 3.0],[-4.0,-7.5,-1.5],[20.0, 0.0, 3.0]];

dev = [
    [gpio,ethusb,micro,hdmi,sd,audio],          // 2,3 B+
    [gpio,ethusb,usbc,mhdmi1,mhdmi2,sd,audio],  // 4 B+
    [gpio,micro,hdmi,sd,audio,usb_a],           // A+
    [gpio_z,sd_z,hdmi_z,uusb_d,uusb_p]          // Zero
];

dev_e = [
    [micro_e],  // 2,3 B+
    [usbc_e],   // 4 B+
    [micro_e],  // A+
    [uusb_e,hdmi_ze,sd_ze]
];

// Devices on the board
devices = dev[rpi];
// Additional cutouts
extras = dev_e[rpi];
// Optional gpio cutout
gpiocut = [gpio,gpio,gpio,gpio_z];
gpco = gpiocut[rpi];

if (show_cutouts) {
    translate([th+padxy, th+padxy, th+padbot+board.z]) {
      color("Purple") {
          for (td=devices) {
            translate(td[0]+td[2]) cube(td[1]+td[3]);
          }
      }
    }
    
    md_show_cutouts();
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
    
    md_show_board();
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

        union() {
            // And optionally vents
            if (addvents) {
                translate([th+padxy, th+padxy, 0]) {
                    translate([0,0,1.8]) cube([box.x-2*(th+padxy), box.y-2*(th+padxy),0.5]);
                    add_vents(box.x-2*(th+padxy), box.y-2*(th+padxy));
                }
            }
            
            // If building for a test, remove bulk
            if (testbuild) {
                translate([10,10,-1]) cube(box-[20,20,0]);
            }
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
                gpiogap();

                // And optionally vents - avoiding GPIO cutout
                if (addvents) {
                    translate([th+padxy, th+padxy, box.z-th]) {
                        add_vents(box.x-2*(th+padxy), gpco[0].y);
                    }
                }
            }
            else
            {
                // And optionally vents
                if (addvents) {
                    translate([th+padxy, th+padxy, box.z-th]) {
                        add_vents(box.x-2*(th+padxy), box.y-2*(th+padxy));
                    }
                }
            }
            
            // If building for a test, remove bulk
            if (testbuild) {
                translate([10,10,1]) cube(box-[20,20,0]);
            }
        }
    }

    // Add clamps for the standoffs
    for (m=mountholes[rpi]) {
        if (md_padbot > 0) {
            // Don't build clamps between the boards
            addclamp(m+[th+padxy,th+padxy,th+padbot+board.z+md_padbot+md_board.z], standoff_d, md_padtop);
        } else {
            addclamp(m+[th+padxy,th+padxy,th+padbot+board.z], standoff_d, padtop);
        }
    }

}

module case () {
    difference () {
        outerbox (box, cornerrounding, th);
        cutouts();
    }
    
    for (m=mountholes[rpi]) {
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
                cylinder(d=clamphole_d, h=3, $fn=10);
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
        md_cutouts();
    }
}

module gpiogap() {
    translate([th+padxy, th+padxy, th+padbot+board.z]) {
        translate(gpco[0]) {
            cube(gpco[1]+[0,0,box.z]);
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

vent_d = 3;
vent_sp = 5; // minimum spacing
vent_ofs = 7;
module add_vents (xsize, ysize) {
    ventx = xsize-2*vent_ofs;
    venty = ysize-2*vent_ofs;
    numx = floor((ventx-vent_d) / vent_sp);
    numy = floor((venty-vent_d) / vent_sp);
    xsp  = (ventx-vent_d)/numx;
    ysp  = (venty-vent_d)/numy;
    for (xpos = [vent_ofs : xsp : ventx+xsp]) {
        for (ypos = [vent_ofs : ysp : venty+ysp]) {
            translate([xpos+vent_d/2, ypos+vent_d/2, -0.2]) {
                cylinder(h=th+0.2, d=vent_d, $fn=10);
            }
        }
    }
}
