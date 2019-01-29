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

-- Initializing Database and getting data at first boot
local path = system.pathForFile( "friendfinderdata.db", system.DocumentsDirectory )
local db = sqlite3.open( path )

local tableSetup = [[CREATE TABLE IF NOT EXISTS People ( UserID INTEGER PRIMARY KEY autoincrement,
																					  FirstName,
																					  LastName, 
																					  Gender, 
																					  Sex, 
																					  Birthdate, 
																					  Hobby, 
																					  Email, 
																					  PersonType, 
																					  Username, 
																					  Password);]]
db:exec( tableSetup )

tpeople = {}
 
for row in db:nrows( "SELECT * FROM People" ) do
 
    print( "Row:", row.UserID )
 
    -- Create sub-table at next available index of "people" table
    tpeople[#tpeople+1] =
    {
        UserID = row.UserID,
        FirstName = row.FirstName,
        LastName = row.LastName,
        Gender = row.Gender,
        Sex = row.Sex,
        Birthdate = row.Birthdate,
        Hobby = row.Hobby,
        Email = row.Email,
        PersonType = row.PersonType,
        Username = row.Username,
        Password = row.Password

    }
end


if ( db and db:isopen() ) then
    db:close()
end

-- going to loginView at first boot in default
local function onLoginView( event )
	composer.gotoScene( "loginView" )
end

onLoginView()

-- experiment back end stuff below:
local majdi = person.new("Majdi", "Nurhasan")
majdi.sayName()







