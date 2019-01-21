-----------------------------------------------------------------------------------------
--
-- person.lua
--
-----------------------------------------------------------------------------------------
local M = {}

local function new(firstName, lastName)
    local object = {}

    object.firstName = firstName
    object.lastName = lastName
    
    function object:sayName()
        print(object.firstName .. " " .. object.lastName)
    end

    return object
end

M.new = new

return M