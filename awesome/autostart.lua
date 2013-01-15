local run_once = require("runonce")

-- To run a program on every reload use
--awful.util.spawn("program")

-- If the program should only run on login (once per session) use
--run_once.run("program")

-- Programs that should run on login
--run_once.run("python2 /usr/bin/disper -d CRT-1,DFP-0 -t right -e")
run_once.run("xrandr --output DVI-I-1 --left-of DVI-I-2")
run_once.run("setxkbmap us dvorak")
run_once.run("conky")
run_once.run("wmname LG3D")
run_once.run("nitrogen --restore")

