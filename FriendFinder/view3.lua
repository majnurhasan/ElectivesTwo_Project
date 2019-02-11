-----------------------------------------------------------------------------------------
--
-- view3.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	
	
	local function onFirstView( event )
		composer.gotoScene( "view1" )
	end
	
	local function onSecondView( event )
		composer.gotoScene( "view2" )
	end
	
	local function onThirdView( event )
		composer.gotoScene( "view3" )
	end
	
	local function onFourthView( event )
		composer.gotoScene( "view4" )
	end

	local tabButtons = {
		{ label="Finder", defaultFile="button1.png", overFile="button1-down.png", width = 32, height = 32, onPress=onFirstView },
		{ label="Friends", defaultFile="button1.png", overFile="button1-down.png", width = 32, height = 32, onPress=onSecondView },
		{ label="Groups", defaultFile="button1.png", overFile="button1-down.png", width = 32, height = 32, onPress=onThirdView },
		{ label="Profile", defaultFile="button1.png", overFile="button1-down.png", width = 32, height = 32, onPress=onFourthView },
	}
	
	local tabBar = widget.newTabBar{
		top = display.contentHeight - 50,	
		buttons = tabButtons
	}
	
	local title = display.newText( "Groups Page", display.contentCenterX, 125, native.systemFont, 32 )
	title:setFillColor( 0 )	

	local newTextParams = { text = "Loaded by the third tab's\n\"onPress\" listener\nspecified in the 'tabButtons' table", 
							x = display.contentCenterX + 10, 
							y = title.y + 215, 
							width = 310, 
							height = 310, 
							font = native.systemFont, 
							fontSize = 14, 
							align = "center" }
	local summary = display.newText( newTextParams )
	summary:setFillColor( 0 ) 
	

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( summary )
	sceneGroup:insert( tabBar )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

	elseif phase == "did" then

	end
end

function scene:destroy( event )
	local sceneGroup = self.view

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
