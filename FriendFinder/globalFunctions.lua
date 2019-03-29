-----------------------------------------------------------------------------------------
--
-- globalFunctions.lua
--
-----------------------------------------------------------------------------------------
local glCommands = {}

    local function EmptyTablesCommand()
        -- Person logged in
        tloggedInUser = {}
        tloggedInUserHobbies = {}
        tloggedInUserEvents = {}
        tloggedInUserHobbyGroups = {}
        tloggedInUserFriends = {}
        tloggedInUserWaves = {}
        -- Passed on Global Variables
        selectedGroup = {}
    end

glCommands.EmptyTablesCommand = EmptyTablesCommand

return glCommands


