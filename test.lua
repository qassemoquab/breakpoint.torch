breakpoint = require 'breakpoint'

local a = 0
local b = 1
c = 2
local d = torch.Tensor(10)
local e = 10

while true do
   for i = 1, 2 do
      d:uniform()
      breakpoint('in for loop i = ' .. i)
   end   

   d:uniform()
   local b = 3
   local f = 5
   breakpoint('in while loop')
end

