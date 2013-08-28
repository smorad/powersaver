powersaver
==========

Arduino power saver


This little script is running on my chipKit Pic32. Using a pyroelectric IR scanner wired into port 2, it will detect
if there are any humans in the room. Using the program counter, or instruction pointer, and some arithmetic, the chip will
open the relays on port 4 if no human has been detected in the last 30 minutes. This will power off whatever connects to the relays
(in this case I am planning on connecting lamps and a TV).
