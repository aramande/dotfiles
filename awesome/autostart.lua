local run_once = require("runonce")

-- To run a program on every reload use
--awful.util.spawn("program")

-- If the program should only run on login (once per session) use
--run_once.run("program")

-- Programs that should run on login
run_once.run("setxkbmap -layout us -variant euro")
run_once.run("conky")

