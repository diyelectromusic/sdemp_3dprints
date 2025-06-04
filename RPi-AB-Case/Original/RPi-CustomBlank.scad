/*
// Simple DIY Electronic Music Projects
//    diyelectromusic.wordpress.com
//
// Raspberry Pi Cases - Custom Definitionm File
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
