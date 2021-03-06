local ok, P = pcall(require, 'posix.signal')
if not ok then 
   print('could not find luaposix ; please do "luarocks install luaposix"')
   function breakpoint(label) end
   return
end

local debug_flag = false

local function switch_debug()
   debug_flag = not debug_flag
   if debug_flag then
      print('')
      print('==============================')
      print('======= DEBUG MODE [ON] ======')
      print('Torch will stop at breakpoints')
      print('==============================')
      print('')
   else
      print('')
      print('==============================')
      print('======= DEBUG MODE [OFF]======')
      print('==============================')
      print('')
   end
end

local function breakpoint(label)
   if debug_flag then
      print('')
      print('==============================')
      print('Breakpoint : '.. label)
      print('Type "break" to resume execution')
      print('Type Ctrl+C (+ Enter) to switch off debug mode')
      print('==============================')
      print('')
      debug_repl()
   end
end


function debug_repl()

    -- copied from http://stackoverflow.com/questions/33068607/how-can-i-use-the-torch-repl-for-debugging
    require 'trepl'

    local save = {}
    local empty = {}

    -- copy upvalues to _G
    local i = 1
    local func = debug.getinfo(3, "f").func
    while true do
        local k, v = debug.getupvalue(func, i)
        if k ~= nil then
            if _G[k] then
               save[k] = _G[k]
            else 
               empty[k] = 1 
            end
            _G[k] = v
        else
            break
        end
        i = i + 1
    end

    -- copy locals to _G
    local i = 1
    while true do
        local k, v = debug.getlocal(3, i)
        if k ~= nil then
            if _G[k] then
               save[k] = save[k] or _G[k]
            else 
               empty[k] = 1 
            end
            _G[k] = v
        else
            break
        end
        i = i + 1
    end

    repl()

    for k,v in pairs(save) do
       _G[k] = v
    end
    for k,v in pairs(empty) do
       _G[k] = nil
    end
end


P.signal(P.SIGINT, switch_debug)

return breakpoint
