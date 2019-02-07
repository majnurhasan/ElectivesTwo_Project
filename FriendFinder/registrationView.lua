-----------------------------------------------------------------------------------------
--
-- registrationView.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	
	local title = display.newText( "Registration", display.contentCenterX, 35, native.systemFont, 30 )
	title:setFillColor( 0 )	-- black
	
	local function onLoginView( event )
		composer.gotoScene( "loginView" )
	end

	usernameRParams = { text = "Username:", 
						x = 80, 
						y = title.y + 55, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local username = display.newText( usernameRParams )
	username:setFillColor( 0 )

	passwordRParams = { text = "Password:", 
						x = 85, 
						y = username.y + 35, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local password = display.newText( passwordRParams )
	password:setFillColor( 0 )

	firstNameParams = { text = "First Name:", 
						x = 99, 
						y = password.y + 35, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local firstName = display.newText( firstNameParams )
	firstName:setFillColor( 0 )

	lastNameParams = { text = "Last Name:", 
						x = 100, 
						y = firstName.y + 35, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local lastName = display.newText( lastNameParams )
	lastName:setFillColor( 0 )

	genderParams = { text = "Gender:", 
						x = 106, 
						y = lastName.y + 35, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local gender = display.newText( genderParams )
	gender:setFillColor( 0 )

	sexParams = { text = "Sex:", 
						x = 139, 
						y = gender.y + 35, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local sex = display.newText( sexParams )
	sex:setFillColor( 0 )

	birthdateParams = { text = "Birthdate:", 
						x = 93, 
						y = sex.y + 35, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local birthdate = display.newText( birthdateParams )
	birthdate:setFillColor( 0 )

	hobbyParams = { text = "Main Hobby:", 
						x = 91, 
						y = birthdate.y + 35, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local hobby = display.newText( hobbyParams )
	hobby:setFillColor( 0 )

	emailParams = { text = "Email:", 
						x = 123, 
						y = hobby.y + 35, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local email = display.newText( emailParams )
	email:setFillColor( 0 )

	personTypeParams = { text = "Person Type:", 
						x = 85, 
						y = email.y + 35, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local personType = display.newText( personTypeParams )
	personType:setFillColor( 0 )

	local function addHobbyButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			print("Add hobbies")

		end
	end

	local function backButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			onLoginView()
		end
	end

	local function registerButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			print("Register")
		end
	end

	local addHobbyButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = addHobbyButtonEvent,
			x = display.contentCenterX,
			y = 440
		}
	)

	local backButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = backButtonEvent,
			x = 70,
			y = 440
		}
	)

	local registerButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = registerButtonEvent,
			x = 250,
			y = 440
		}
	)

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( username )
	sceneGroup:insert( password )
	sceneGroup:insert( firstName )
	sceneGroup:insert( lastName )
	sceneGroup:insert( gender )
	sceneGroup:insert( sex )
	sceneGroup:insert( birthdate )
	sceneGroup:insert( hobby )
	sceneGroup:insert( email )
	sceneGroup:insert( personType )
	sceneGroup:insert( addHobbyButton )
	sceneGroup:insert( backButton )
	sceneGroup:insert( registerButton )

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