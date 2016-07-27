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

