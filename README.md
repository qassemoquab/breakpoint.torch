breakpoint.torch
====================

A simple breakpoint script for Torch based on luaposix if you're too lazy to install a proper debugger.

Usage : 
``` 
breakpoint = require 'breakpoint'
```

Then, somewhere in the code :
```
breakpoint('label') 
```

To set the breakpoint flag to active at the beginning :
```
breakpoint = require 'breakpoint.active'
```

It catches the SIGINT (interrupt signal, aka Ctrl+C) to activate the breakpoint flag.
If you want to quit, you can sent a SIGQUIT (quit signal, aka Ctrl+backslash).

At the breakpoint position, it reads all local variables and upvalues, and opens a repl().
The point is to see what values a function can see at a given position in the code.
To quit the repl, type "break". Global variables will be restored to their original values if there is overlap with the local variables names.

To set the breakpoint flag to false and resume smooth execution, just Ctrl+C again (+ Enter).

It's useful if you want to probe what's happening in the code while it runs. 
Change global values only if you know what's going on.

Example :
```
breakpoint = require 'breakpoint'

local a = 0
local b = 1
c = 2
local t = torch.Tensor(2)

while true do
   for i = 1, 2 do
      t:uniform()
      breakpoint('in for loop i = ' .. i)
   end   

   local b = 3
   local c = 4
   local d = 5
   breakpoint('in while loop')
end
```

Example with test.lua

```
th test.lua 
^C	
==============================	
======= DEBUG MODE [ON] ======	
Torch will stop at breakpoints	
==============================	
	
	
==============================	
Breakpoint : in for loop i = 1	
Type "break" to resume execution	
Type Ctrl+C (+ Enter) to switch off debug mode	
==============================	
	
th> a,b,c,d
0	1	2	

th> t
 0.3380
 0.1311
[torch.DoubleTensor of size 2]

th> break
	
==============================	
Breakpoint : in for loop i = 2	
Type "break" to resume execution	
Type Ctrl+C (+ Enter) to switch off debug mode	
==============================	
	
th> a,b,c,d
0	1	2	

th> t
 0.4429
 0.7080
[torch.DoubleTensor of size 2]

th> break
	
==============================	
Breakpoint : in while loop	
Type "break" to resume execution	
Type Ctrl+C (+ Enter) to switch off debug mode	
==============================	
	
th> a,b,c,d
0	3	4	5	

th> break
	
==============================	
Breakpoint : in for loop i = 1	
Type "break" to resume execution	
Type Ctrl+C (+ Enter) to switch off debug mode	
==============================	
	
th> a,b,c,d
0	1	2	

th> ^C
	
==============================	
======= DEBUG MODE [OFF]======	
==============================	
	
th> break

-- execution resumes, but can't quit with Ctrl+C

^\Quit (core dumped)
```
