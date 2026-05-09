# Agent instructions

## Verifying a KiCad schematic

Don't read `.kicad_sch` directly — nets only resolve after KiCad processes it. Export a netlist:

    cd <project_dir> && kicad-cli sch export netlist --format kicadsexpr -o "$TMPDIR/out.net" <name>.kicad_sch
