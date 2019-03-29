-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
date = os.date( "*t" ) -- local time right now

-- Local Tables
tpeople = {}
thobbies = {}
tgroups = {}
tevents = {}
twaves = {}
trwaves = {}
tpeopleHobbyGroups = {}
tpeopleFriends = {}
tpeopleEvents = {}
tpeopleWaves = {}
tpeopleRWaves = {}
-- Person logged in
tloggedInUser = {}
tloggedInUserHobbies = {}
tloggedInUserEvents = {}
tloggedInUserHobbyGroups = {}
tloggedInUserFriends = {}
tloggedInUserWaves = {}
tloggedInUserRWaves = {}
-- Passed on Global Variables
selectedGroup = {}
selectedNearbyPerson = {}
selectedNearbyPersonHobbies = {}
selectedNearbyPersonEvents = {}
selectedNearbyPersonHobbyGroups = {}

-- call modules
local widget = require "widget"
local composer = require "composer"
local person = require "person"
local sqldb = require "sqldb"
local sqlite3 = require "sqlite3" 

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

sqldb.OpenDatabase()
sqldb.InitializeTables()
sqldb.LoadDataFromTables()
sqldb.ConstructInitialDataInTables()
sqldb.CloseDatabase()

-- going to loginView at first boot in default
local function onLoginView( event )
	composer.gotoScene( "loginView" )
end

onLoginView()

-- experiment back end stuff below:
local majdi = person.new("Majdi", "Nurhasan")
majdi.sayName()
print("Date and Time below:")  
print("Date: " ..  os.date( "%x" ) .. "  Time: " .. date.hour .. ":" .. date.min)







