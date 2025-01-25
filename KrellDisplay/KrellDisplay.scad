/*
// Simple DIY Electronic Music Projects
//    diyelectromusic.wordpress.com
//
// Forbidden Planet Krell Display
//    https://diyelectromusic.com/2025/01/25/forbidden-planet-krell-display/
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

box_l = 100;
box_w = 65;
box_h = 20;
box_th = 2;
dis_r = 18;
dis_h = 2;
dis_th = 1;
pcb_h = 6;       // Height of PCB from front
pcbfix_w = 6.0;
pcbfix_d = 2.7;  // M2.5 screws required
pcbfix_h = 6.0;  // 6mm depth screws
res = 20;

show_frame = 1;
show_quadframe = 0;
show_insert = 0;
show_support = 0;
show_quadsupport = 0;

if (show_frame) {
    difference () {
        cube([box_w, box_l, box_th]);
        union () {
            translate([0,0,-0.05]) {
                krell(box_w/2,box_l/4, dis_r, dis_h+0.1);
                krell(box_w/2,box_l*3/4, dis_r, dis_h+0.1);
            }
        }
    }
    difference() {
        cube([box_w, box_l, box_h]);
        translate([box_th,box_th,0]) {
            cube([box_w-2*box_th, box_l-2*box_th, box_h+0.1]);
        }
    }
    pcbfixing(box_th,box_th,box_th,pcb_h);
    pcbfixing(box_w-box_th-pcbfix_w,box_th,box_th,pcb_h);
    pcbfixing(box_th,box_l-box_th-pcbfix_w,box_th,pcb_h);
    pcbfixing(box_w-box_th-pcbfix_w,box_l-box_th-pcbfix_w,box_th,pcb_h);
}


if (show_quadframe) {
    translate([-box_w*3,0,0]) {
        difference () {
            cube([box_w*2, box_l, box_th]);
            union () {
                translate([0,0,-0.05]) {
                    krell(box_w/2,box_l/4, dis_r, dis_h+0.1);
                    krell(box_w/2,box_l*3/4, dis_r, dis_h+0.1);
                    krell(box_w*3/2,box_l/4, dis_r, dis_h+0.1);
                    krell(box_w*3/2,box_l*3/4, dis_r, dis_h+0.1);
                }
            }
        }
        difference() {
            cube([box_w*2, box_l, box_h]);
            translate([box_th,box_th,0]) {
                cube([box_w*2-2*box_th, box_l-2*box_th, box_h+0.1]);
            }
        }
        pcbfixing(box_th,box_th,box_th,pcb_h);
        pcbfixing(box_w-box_th-pcbfix_w,box_th,box_th,pcb_h);
        pcbfixing(box_th,box_l-box_th-pcbfix_w,box_th,pcb_h);
        pcbfixing(box_w-box_th-pcbfix_w,box_l-box_th-pcbfix_w,box_th,pcb_h);

        translate([box_w,0,0]) {
            pcbfixing(box_th,box_th,box_th,pcb_h);
            pcbfixing(box_w-box_th-pcbfix_w,box_th,box_th,pcb_h);
            pcbfixing(box_th,box_l-box_th-pcbfix_w,box_th,pcb_h);
            pcbfixing(box_w-box_th-pcbfix_w,box_l-box_th-pcbfix_w,box_th,pcb_h);
        }
    }
}


sup_l = (box_l/4) / cos(30);
sup_w = 1.0;
sup_h = box_h-10;
sup_fh = box_h-box_th-4; // NB: box_h is external height, so includes box_th
sup_d = 1.8;
if (show_support) {
    translate([0,-box_l*2,0]) {
        //translate([0,0,-box_th])
        //    cube([box_w, box_l, box_th]);

        difference () {
            union () {

                translate([box_w/2, box_l/4, 0]) {
                    supports();
                }

                translate([box_w/2, box_l*3/4, 0]) {
                    supports();
                }
                
                translate([0.1,box_l/2 - sup_w,0])
                    cube([box_w-0.2,sup_w*2,sup_fh]);
            }
            difference() {
                cube([box_w, box_l, box_h]);
                translate([box_th,box_th,0]) {
                    cube([box_w-2*box_th, box_l-2*box_th, box_h+0.1]);
                }
            }
        }
    }
}

if (show_quadsupport) {
    translate([0,-box_l*4,0]) {
        //translate([0,0,-box_th])
        //    cube([box_w*2, box_l, box_th]);

        difference () {
            union () {
                translate([box_w/2, box_l/4, 0]) {
                    supports();
                }

                translate([box_w/2, box_l*3/4, 0]) {
                    supports();
                }
                
                translate([box_w*3/2, box_l/4, 0]) {
                    supports();
                }

                translate([box_w*3/2, box_l*3/4, 0]) {
                    supports();
                }
                
                translate([0.1,box_l/2 - sup_w,0])
                    cube([box_w*2-0.2,sup_w*2,sup_fh]);

                translate([box_w,0.1,0])
                    cube([sup_w,box_l-box_th,sup_fh]);

            }
            difference() {
                cube([box_w*2, box_l, box_h]);
                translate([box_th,box_th,0]) {
                    cube([box_w*2-2*box_th, box_l-2*box_th, box_h+0.1]);
                }
            }
        }
    }
}


module supports () {
    difference() {
        union() {
            for(ang = [0 : 60: 360])
                rotate([0,0,ang]) {
                    translate([-sup_w/2,-sup_w/2,0]) {
                        difference() {
                            cube([sup_l,sup_w,sup_h]);
                            translate([9,-0.1,sup_h-1])
                                cube([3,sup_w+0.2,1.1]);
                        }
                    }
                    translate([12-sup_w/2,-sup_w/2,sup_h]) {
                        cube([sup_l-12,sup_w,sup_fh-sup_h]);
                    }
                }
        }
        translate([0,0,sup_h-2.0])
            cylinder(h=2.1,d=8);
    }
}


if (show_insert) {
    sph_r = 2;
    ins_r = dis_r+3;
    // Scale down slightly to give a bit of fitting tolerance
    //scale([0.98,0.98,1.0]) {
    {
        translate([box_w+10, 0, sph_r]) {
            // Packing of the circles:
            //   Horizontal distance = radius
            //   Vertical distance = radius * SQR(3)
            //   Every other row offset by 1 radius
            translate([0,0,-dis_th]) {
                difference() {
                    cube([ins_r*2,ins_r*2,dis_th]);
                    union() {
                        for(xpos = [sph_r:sph_r*2:ins_r*2-sph_r]) {
                            for (ypos = [sph_r:sph_r*2*sqrt(3):ins_r*2-sph_r]) {
                                translate([xpos,ypos,-sph_r/2-0.05]) {
                                    cylinder(sph_r+0.1,r=sph_r-0.5,$fn=res);
                                }
                                translate([xpos+sph_r,ypos+sph_r*sqrt(3),-sph_r/2-0.05]) {
                                    cylinder(sph_r+0.1,r=sph_r-0.5,$fn=res);
                                }
                            }
                        }
                    }
                }
            }
            difference() {
                union() {
                    for(xpos = [sph_r:sph_r*2:ins_r*2-sph_r]) {
                        for (ypos = [sph_r:sph_r*2*sqrt(3):ins_r*2-sph_r]) {
                            translate([xpos,ypos,0]) {
                                difference() {
                                    sphere(sph_r,$fn=res);
                                    union () {
                                        sphere(sph_r-0.5,$fn=res);
                                        translate([-sph_r,-sph_r,-sph_r-0.1])
                                            cube([sph_r*2, sph_r*2, sph_r]);
                                    }
                                }
                            }
                            translate([xpos+sph_r,ypos+sph_r*sqrt(3),0]) {
                                difference() {
                                    sphere(sph_r,$fn=res);
                                    union () {
                                        sphere(sph_r-0.5,$fn=res);
                                        translate([-sph_r,-sph_r,-sph_r-0.1])
                                            cube([sph_r*2, sph_r*2, sph_r]);
                                    }
                                }
                            }
                        }
                    }
                }
                difference () {
                    cube([ins_r*2, ins_r*2, 20]);
                    translate([0,0,-0.05]) {
                        krell(ins_r, ins_r, dis_r, 20+0.1);
                    }
                }
            }
            translate([ins_r, ins_r, 0]) {
                h = dis_h+0.1;
                krell_mark(h,0, 0.5);
                krell_mark(h,60, 0.5);
                krell_mark(h,120, 0.5);
                krell_mark(h,180, 0.5);
            }
        }
    }
}

module krell(x,y,r,h) {
    dis_arc = 15;
    translate([x, y, 0]) {
        linear_extrude(h) {
            arc(0,[-45-dis_arc,225+dis_arc],r,100);
            rd = r/4;
            translate([-rd/2, -rd/2, 0])
                square(rd);
        }
        krell_mark(h,0);
        krell_mark(h,60);
        krell_mark(h,120);
        krell_mark(h,180);
    }
}

module krell_mark(h,ang,tol=0) {
    rotate(ang)
        translate([dis_r, 0, 0])
            rotate([0,0,180])
                cylinder(h,d=(dis_r/3)-tol,$fn=3);
}

module pcbfixing (x,y,z,h) {
    translate ([x,y,z]) {
        difference() {
            cube([pcbfix_w, pcbfix_w, h]);
            translate ([pcbfix_w/2,pcbfix_w/2,h-pcbfix_h])
                cylinder(pcbfix_h+0.01,d=pcbfix_d,$fn=10);
        }
    }
}


// Taken from https://openhome.cc/eGossip/OpenSCAD/SectorArc.html
module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

