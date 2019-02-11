-----------------------------------------------------------------------------------------
--
-- view4.lua
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
	
	local title = display.newText( "Profile", display.contentCenterX, 0, native.systemFont, 32 )
	title:setFillColor( 0 )	

	local namePParams = { text = "Name: " .. tloggedInUser.FirstName .. " " .. tloggedInUser.LastName, 
						x = display.contentCenterX, 
						y = title.y + 60, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local nameHeader = display.newText( namePParams )
	nameHeader:setFillColor( 0 )

	local scrollView = widget.newScrollView
	{
		left = 0,
		top = 0,
		width = display.contentWidth,
		height = 430,
		topPadding = 30,
		bottomPadding = 30,
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false
	}

	scrollView:insert(title)
	scrollView:insert(nameHeader)

	sceneGroup:insert( background )
	sceneGroup:insert( tabBar )
	sceneGroup:insert( scrollView )
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
