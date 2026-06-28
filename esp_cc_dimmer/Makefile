# Regenerate docs/img renders from KiCad + enclosure sources.
#   make            rebuild stale renders
#   make -B         force all
#   make clean

IMG    := docs/img
B      := build
PCB    := esp_cc_dimmer.kicad_pcb
SCAD   := enclosure/esp_cc_dimmer_box.scad
DEPS   := enclosure/YAPPgenerator_v3.scad

F3D    := f3d --no-config --no-background -q -t --anti-aliasing=ssaa --rendering-backend=egl
KICAD  := kicad-cli pcb render --quality high --background transparent -w 1600 -h 1200

RENDERS := $(addprefix $(IMG)/,pcb_top.webp pcb_bottom.webp base.webp lid.webp knob.webp shelf_nut.webp)

.PHONY: all clean
all: $(RENDERS)
.DELETE_ON_ERROR:

# PNG -> trimmed lossless WebP
$(IMG)/%.webp: $(B)/%.png
	magick $< -trim +repage -define webp:lossless=true $@

$(B) $(IMG):
	mkdir -p $@

$(B)/pcb_top.png: $(PCB) | $(B)
	$(KICAD) --side top -o $@ $<
$(B)/pcb_bottom.png: $(PCB) | $(B)
	$(KICAD) --side bottom -o $@ $<

# Base/lid split out of the single YAPP scad via shell flags
$(B)/box_base.stl: $(SCAD) $(DEPS) | $(B)
	openscad -o $@ -D 'printLidShell=false' -D 'printBaseShell=true' $<
$(B)/box_lid.stl: $(SCAD) $(DEPS) | $(B)
	openscad -o $@ -D 'printLidShell=true' -D 'printBaseShell=false' $<

$(B)/base.png: $(B)/box_base.stl | $(B)
	$(F3D) $< --output $@ --resolution 1200,1000 --up=+Z --camera-azimuth-angle=-40 --camera-elevation-angle=35 --color=0.25,0.55,0.85 --roughness=0.6
$(B)/lid.png: $(B)/box_lid.stl | $(B)
	$(F3D) $< --output $@ --resolution 1200,1000 --up=+Z --camera-azimuth-angle=-40 --camera-elevation-angle=35 --color=0.25,0.55,0.85 --roughness=0.6
$(B)/knob.png: enclosure/dimmer_knob_textured.stl | $(B)
	$(F3D) $< --output $@ --resolution 1000,1000 --up=+Z --camera-azimuth-angle=-30 --camera-elevation-angle=20 --color=0.3,0.78,0.35 --roughness=0.7
$(B)/shelf_nut.png: enclosure/shelf_nut.step | $(B)
	$(F3D) --load-plugins=occt $< --output $@ --resolution 1000,1000 --up=-Z --camera-azimuth-angle=-35 --camera-elevation-angle=30 --color=0.55,0.57,0.6 --roughness=0.6

clean:
	rm -rf $(B)
