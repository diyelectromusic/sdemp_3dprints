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
show_board=1; // [0:No, 1:Yes]
show_base=1;  // [0:No, 1:Yes]
show_top=1;   // [0:No, 1:Yes]
show_split=1; // [0:No, 1:Yes]

// RPi form factor versions:
rpi=0; // [0: 2 3 B+, 1: 4 B+, 2: 3 A+, 3: Zero]

topvents=0;    // [0:No, 1:Yes]
botvents=0;    // [0:No, 1:Yes]
gpiogap=0;     // [0:No, 1:Yes]
sdcardgap=1;   // [0:No, 1:Yes]
clampmounts=1; // [0:No, 1:Yes]

// For debugging
show_cutouts=0; // [0:No, 1:Yes]
// Shorter print for testing dimensions
testbuild=0;    // [0:No, 1:Yes]

// Case split height (advanced)
split = 9;

module __Customizer_Limit__ () {}

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
// Leave md_pad.z/md_padtop as zero if no additional boards.
md_pad = [0, 0, 0];

// Addititonal spacing in x,y for main box
// NB: x adds to SD-card end; y to GPIO side; z is height above MD board
md_ext = [0,0,0];


////////////////////////////////////////////////////////////////////
//
// Main RPI SCAD definitions
//
////////////////////////////////////////////////////////////////////
include <RPIABCaseModule.scad>

