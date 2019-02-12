-----------------------------------------------------------------------------------------
--
-- moreRegistrationView.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local sqldb = require "sqldb"
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	
	
	titleOne = display.newText( "More Hobbies", display.contentCenterX, 25, native.systemFont, 30 )
	titleOne:setFillColor( 0 )
	
	titleTwo = display.newText( "Personal Description", display.contentCenterX, 180, native.systemFont, 30 )
	titleTwo:setFillColor( 0 )

	extraHobbyParams = { text = "Extra Hobby:", 
						x = 90, 
						y = titleOne.y + 60, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local extraHobby = display.newText( extraHobbyParams )
	extraHobby:setFillColor( 0 )
	
	local function onRegistrationView( event )
		composer.gotoScene( "registrationView" )
	end
	
	local function backButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			onRegistrationView()
		end
	end

	local backButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = backButtonEvent,
			x = 70,
			y = 455
		}
	)
	

	sceneGroup:insert( background )
	sceneGroup:insert( titleOne )
	sceneGroup:insert( titleTwo )
	sceneGroup:insert( backButton )
	sceneGroup:insert( extraHobby )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then


	elseif phase == "did" then
		extraHobbymRTextField = native.newTextField( extraHobbyParams.x + 130, titleOne.y + 45, 170, 35)
		extraHobbymRTextField:setTextColor( 0 )
		extraHobbymRTextField.isEditable = true
		extraHobbymRTextField.size = 20
		extraHobbymRTextField.text = ""

		--passwordRTextField = native.newTextField( passwordRParams.x + 130, usernameRTextField.y + 39, 170, 35)
		--passwordRTextField:setTextColor( 0 )
		--passwordRTextField.isEditable = true
		--passwordRTextField.size = 20
		--passwordRTextField.isSecure = true
		--passwordRTextField.text = ""


		sceneGroup:insert( extraHobbymRTextField )
		--sceneGroup:insert( passwordRTextField )
		

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		extraHobbymRTextField:removeSelf()
		extraHobbymRTextField = nil
		
		--passwordRTextField:removeSelf()
		--passwordRTextField = nil
	elseif phase == "did" then


	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	-- add code here to reset textfields
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene