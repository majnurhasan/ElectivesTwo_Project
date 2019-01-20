-----------------------------------------------------------------------------------------
--
-- person.lua
--
-----------------------------------------------------------------------------------------
module(..., package.seeall)

local function new(firstName, lastName)
    local object = {}

    object.firstName = firstName
    object.lastName = lastName
    
    function object:sayName()
        print(object.FirstName .. " " .. object.LastName)
    end

    return object
end