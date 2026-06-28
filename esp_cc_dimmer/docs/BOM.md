# Bill of Materials

Board: **68.25 × 52.0 mm**, 2-layer. Reference designators match `esp_cc_dimmer.kicad_sch`.

| # | Refs | Qty | Value / Part | Package | Notes |
|---|------|-----|--------------|---------|-------|
| 1 | U3 | 1 | Seeed XIAO ESP32-C3 | XIAO SMD module | Wi-Fi MCU running ESPHome |
| 2 | PS1 | 1 | Mean Well NLDD-1050H | PCB-mount module | Constant-current LED driver, 10–56 V in, PWM dim. Any NLDD-350/500/700/1050H fits |
| 3 | U4 | 1 | LX8015 | SOT-style buck | Wide-input buck → 3V3 for the MCU |
| 4 | U2 | 1 | Vishay VEML7700 | 6-pin OPLGA | I²C ambient-light sensor |
| 5 | SW1 | 1 | Alps EC11E15244G1 | EC11 vertical | Rotary encoder with push switch (knob) |
| 6 | J1, J2 | 2 | WJ15EDGRC-3.81-02P | 3.81 mm 2-pin | Pluggable terminal blocks (power in / LED out) |
| 7 | C2 | 1 | 100 µF 63 V | Radial Ø8 mm | Input bulk electrolytic |
| 8 | C11 | 1 | 4.7 µF 100 V | 1210 | Buck input cap |
| 9 | C8 | 1 | 10 µF | 1210 | Buck output / 3V3 cap |
| 10 | C1, C3 | 2 | 1 µF | 0603 | Decoupling |
| 11 | R1, R2 | 2 | 4.7 kΩ | 0603 | I²C pull-ups |

**Mechanical (3D-printed):** YAPP_Box enclosure (`enclosure/esp_cc_dimmer_box.3mf`) and encoder knob (`enclosure/dimmer_knob.FCStd`).
