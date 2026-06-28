//-----------------------------------------------------------------------
// YAPP_Box enclosure for esp_cc_dimmer
//
// Generated from esp_cc_dimmer.kicad_pcb (board 68.25 x 52.0 mm).
//
// Board is rotated 90deg into the box so YAPP's faces match the request:
//     LEFT  wall = power-in  J2
//     RIGHT wall = power-out J1
//     FRONT wall = USB-C     U3   ("down" side)
//     LID        = encoder knob SW1 ("top")
//
// KiCad -> YAPP transform (yappCoordPCB, pure rotation, not mirrored):
//     PCB-X (from back) = kicad_y - 69.25     (pcbLength = 52.0)
//     PCB-Y (from left) = kicad_x - 66.5      (pcbWidth  = 68.25)
//
// Tallest enclosed part is PS1 (NLDD-1050H) at 12.5 mm; the EC11 shaft
// pokes out through the lid knob hole.
//-----------------------------------------------------------------------

include <./YAPPgenerator_v3.scad>

//-- which part(s) do you want to print?
printBaseShell        = true;
printLidShell         = true;
printSwitchExtenders  = false;
printDisplayClips     = false;

//-- PCB ----------------------------------------------------------------
pcbLength           = 52.0;  // X, back->front
pcbWidth            = 68.25; // Y, left->right
pcbThickness        = 1.6;
standoffHeight      = 4.0;   // clears THT leads (C2, J1/J2) under the PCB
standoffDiameter    = 6;
standoffPinDiameter = 2.8;   // locating pin into the M3 (3.2 mm) holes
standoffHoleSlack   = 0.3;

pcb =
[
  ["Main", pcbLength,pcbWidth, 0,0, pcbThickness, standoffHeight, standoffDiameter, standoffPinDiameter, standoffHoleSlack]
];

//-- padding between pcb and inside wall
paddingFront        = 1;
paddingBack         = 1;
paddingRight        = 1;
paddingLeft         = 1;

//-- box shell ----------------------------------------------------------
wallThickness       = 2.0;
basePlaneThickness  = 1.5;
lidPlaneThickness   = 1.5;

//-- internal height above PCB top = (base+lid wall) - (standoff+pcbThk)
//-- = (16+5) - (4+1.6) = 15.4 mm  (PS1 = 12.5 mm -> ~2.9 mm clearance)
baseWallHeight      = 16;    // keeps the 10 mm terminal blocks fully in the base wall
lidWallHeight       = 5;

ridgeHeight         = 4.0;   // must stay <= lidWallHeight
ridgeSlack          = 0.3;
roundRadius         = 2.5;

boxType             = 2;     // 2 = all outside edges chamfered (no fillet overhangs when printing)
printerLayerHeight  = 0.2;

//-- preview controls ---------------------------------------------------
renderQuality       = 8;
previewQuality      = 5;
showSideBySide      = true;
onLidGap            = 0;
colorLid            = "YellowGreen";
colorBase           = "BurlyWood";
showOrientation     = true;
showPCB             = true;

//===================================================================
// *** PCB Supports ***  p0=PCB-X (from back), p1=PCB-Y (from left)
//-------------------------------------------------------------------
pcbStands =
[
   [4.0,   4.0, standoffHeight, yappBoth, yappPin]   // H1 mounting hole (M3)
  ,[48.0,  4.0, standoffHeight, yappBoth, yappPin]   // H2 mounting hole (M3)
  ,[21.0, 45.0, standoffHeight, yappBaseOnly, yappHole] // center support - verify no clash, remove if it fouls
];

connectors = [];

//===================================================================
// *** Cutouts ***
//  Left/Right walls: p0 = PCB-X (from back), p1 = Z height above PCB
//  Front/Back walls: p0 = PCB-Y (from left), p1 = Z height above PCB
//  Lid:              p0 = PCB-X (from back), p1 = PCB-Y (from left)
//-------------------------------------------------------------------
cutoutsBase = [];

cutoutsLid  =
[
  //-- EC11 encoder bushing/shaft (knob on top); 8 mm hole clears the 7 mm bushing.
  //-- Centered on the shaft axis = footprint-local (7.5, 2.5), NOT the origin (pad A).
  //-- yappCenter is REQUIRED: a bare yappCircle anchors its bbox corner, shifting it +radius in both axes.
   [9.0, 56.5, 0, 0, 4.0, yappCircle, yappCenter]           // SW1 knob
  // Optional VEML7700 ambient-light window (uncomment if needed):
  ,[5.2, 18.4, 6, 8, 0, yappRectangle, yappCenter]        // U2 light sensor
];

cutoutsLeft =
[
  //-- power-in Phoenix block: body +7.5 above / -3.4 below PCB top (1.6 mm
  //-- board + 1.8 mm pin overhang), 8.8 mm wide. Center Z = 2.05, +0.3 slack.
   [25.25, 2.05, 9.4, 11.5, 0, yappRectangle, yappCenter]   // J2
];

cutoutsRight =
[
  //-- power-out Phoenix block: same body as J2 (see cutoutsLeft).
   [25.25, 2.05, 9.4, 11.5, 0, yappRectangle, yappCenter]   // J1
];

cutoutsFront =
[
  //-- USB-C on the XIAO ESP32-C3: receptacle ~8.9 w x 3.3 h, bottom 1.2 above
  //-- PCB top -> spans Z 1.2..4.5. Center Z = 3.0, opening sized with slack.
   [58.0, 3.0, 10, 4.5, 1.5, yappRoundedRect, yappCenter]    // U3
];

cutoutsBack = [];

//-- snap-fit clips on the two long walls (yappSymmetric -> a mirrored pair
//-- per wall, so 2 clips each). pos is along shellWidth (74.25).
snapJoins   =
[
   [20, 10, yappFront, yappBack, yappCenter, yappSymmetric]
];

//-- external M3 mounting ears, one on each short wall, on the base, shifted
//-- ~1/3 along shellLength (58) toward the back. 3.2 = M3 clearance hole.
boxMounts   =
[
   [19, 3.2, 0, 4, yappLeft, yappRight, yappCenter]
];
lightTubes  = [];
pushButtons = [];
labelsPlane = [];

//===================================================================
YAPPgenerate();
