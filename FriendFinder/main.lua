-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- Local Tables
tpeople = {}
thobbies = {}
tgroups = {}
tpeopleHobbyGroups = {}
tpeopleFriends = {}
-- Person logged in
tloggedInUser = {}

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







