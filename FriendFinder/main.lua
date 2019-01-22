-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"
local person = require "person"
local sqlite3 = require "sqlite3" 

-- Initializing Database
local path = system.pathForFile( "friendfinderdata.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

-- Create empty "tpeople" table
local tpeople = {}
 
-- Loop through database table rows via a SELECT query
for row in db:nrows( "SELECT * FROM People" ) do
 
    print( "Row:", row.UserID )
 
    -- Create sub-table at next available index of "people" table
    tpeople[#tpeople+1] =
    {
        FirstName = row.FirstName,
        LastName = row.LastName
    }
end

if ( db and db:isopen() ) then
    db:close()
end

-- end of database usage

-- going to loginView at first boot in default
local function onLoginView( event )
	composer.gotoScene( "loginView" )
end

onLoginView()

-- experiment back end stuff below:
local majdi = person.new("Majdi", "Nurhasan")
majdi.sayName()
for k,v in pairs(tpeople) do
	print( k,v )
	print("is this working")
end






