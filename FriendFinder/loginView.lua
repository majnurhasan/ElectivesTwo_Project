-----------------------------------------------------------------------------------------
--
-- loginView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	-- functions below
	local function textListener( event )
		if ( event.phase == "began" ) then

		elseif ( event.phase == "ended" or event.phase == "submitted" ) then
			return event.target.text
		elseif ( event.phase == "editing" ) then
			return event.target.text
		end
	end

	local function loginButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			print( "Button was pressed and released" )
		end
	end


	-- create some text
	local title = display.newText( "FriendFinder", display.contentCenterX, 70, native.systemFont, 50 )
	title:setFillColor( 0 )	-- black

	local loginheader = display.newText("Login", display.contentCenterX, 140, native.systemFont, 30)
	loginheader:setFillColor ( 0 )
	
	local usernameParams = { text = "Username:", 
						x = 80, 
						y = loginheader.y + 70, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local username = display.newText( usernameParams )
	username:setFillColor( 0 )

	local passwordParams = { text = "Password:", 
						x = 80, 
						y = loginheader.y + 110, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local password = display.newText( passwordParams )
	password:setFillColor( 0 )

	local usernameTextField = native.newTextField( usernameParams.x + 140, loginheader.y + 55, 170, 35)
	usernameTextField:setTextColor( 0 )
	usernameTextField.isEditable = true
	usernameTextField.size = 20
	usernameTextField:addEventListener( "userInput", textListener )

	local passwordTextField = native.newTextField( passwordParams.x + 140, loginheader.y + 95, 170, 35)
	passwordTextField:setTextColor( 0 )
	passwordTextField.isEditable = true
	passwordTextField.size = 20
	passwordTextField.isSecure = true	
	passwordTextField:addEventListener( "userInput", textListener )

	local loginButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = loginButtonEvent,
			x = display.contentCenterX,
			y = 280
		}
	)
	
	

	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( loginheader )
	sceneGroup:insert( username )
	sceneGroup:insert( password )
	sceneGroup:insert( usernameTextField )
	sceneGroup:insert( passwordTextField )
	sceneGroup:insert( loginButton )
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene