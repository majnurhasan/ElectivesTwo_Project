-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"
local sqldb = require "sqldb"
local person = require "person"

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

local function onLoginView( event )
	composer.gotoScene( "loginView" )
end

onLoginView()

-- experiment back end stuff below:
local majdi = person.new("Majdi", "Nurhasan")
majdi.sayName()



