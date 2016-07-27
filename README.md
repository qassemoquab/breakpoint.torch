breakpoint.torch
====================

A simple breakpoint script for Torch based on luaposix.

Example :
```
breakpoint = require 'breakpoint'

local a = 0
c = 1
local x = torch.Tensor(10)

while true do
   for i = 1, 2 do
      x:uniform()
      breakpoint('in for loop i = ' .. i)
   end   

   local b = c
   breakpoint('in while loop')
end
```


