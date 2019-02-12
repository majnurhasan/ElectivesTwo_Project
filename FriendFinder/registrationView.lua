-----------------------------------------------------------------------------------------
--
-- registrationView.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local sqldb = require "sqldb"
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	
	title = display.newText( "Registration", display.contentCenterX, 25, native.systemFont, 30 )
	title:setFillColor( 0 )	-- black
	
	local function onLoginView( event )
		composer.gotoScene( "loginView" )
	end

	local function onMoreRegistrationView( event )
		composer.gotoScene( "moreRegistrationView" )
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
						y = username.y + 38, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local password = display.newText( passwordRParams )
	password:setFillColor( 0 )

	firstNameParams = { text = "First Name:", 
						x = 99, 
						y = password.y + 38, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local firstName = display.newText( firstNameParams )
	firstName:setFillColor( 0 )

	lastNameParams = { text = "Last Name:", 
						x = 100, 
						y = firstName.y + 38, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local lastName = display.newText( lastNameParams )
	lastName:setFillColor( 0 )

	genderParams = { text = "Gender:", 
						x = 106, 
						y = lastName.y + 38, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local gender = display.newText( genderParams )
	gender:setFillColor( 0 )

	sexParams = { text = "Sex:", 
						x = 139, 
						y = gender.y + 38, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local sex = display.newText( sexParams )
	sex:setFillColor( 0 )

	birthdateParams = { text = "Birthdate:", 
						x = 93, 
						y = sex.y + 38, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local birthdate = display.newText( birthdateParams )
	birthdate:setFillColor( 0 )

	hobbyParams = { text = "Main Hobby:", 
						x = 91, 
						y = birthdate.y + 38, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local hobby = display.newText( hobbyParams )
	hobby:setFillColor( 0 )

	emailParams = { text = "Email:", 
						x = 123, 
						y = hobby.y + 38, 
						width = 100, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local email = display.newText( emailParams )
	email:setFillColor( 0 )

	personTypeParams = { text = "Person Type:", 
						x = 85, 
						y = email.y + 38, 
						width = 150, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "left" }
	local personType = display.newText( personTypeParams )
	personType:setFillColor( 0 )

	local function moreRegistrationButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			onMoreRegistrationView()
		end
	end

	local function backButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			onLoginView()
		end
	end

	local function registerButtonEvent( event )
		if ( event.phase == "ended" ) then
			if (firstNameRTextField.text == "" or lastNameRTextField.text == ""   or 
				genderRTextField.text == ""    or sexRTextField.text == ""        or 
				birthdateRTextField.text == "" or hobbyRTextField.text == ""      or 
				emailRTextField.text == "" 	   or personTypeRTextField.text == "" or 
				usernameRTextField.text == ""  or passwordRTextField.text == "") 
				then
				local alert = native.showAlert( "Error", "Please fill in all empty details.", {"OK"}, onComplete )
			else
				print("Register Successful!")
				sqldb.OpenDatabase()
				local people = {
					{
						FirstName = firstNameRTextField.text,
						LastName = lastNameRTextField.text,
						Gender = genderRTextField.text,
						Sex  = sexRTextField.text,
						Birthdate = birthdateRTextField.text,
						Hobby = hobbyRTextField.text,
						Email = emailRTextField.text,
						PersonType = personTypeRTextField.text,
						Username = usernameRTextField.text,
						Password = passwordRTextField.text
					}
				}
	
				for i = 1,#people do
					local q = [[INSERT INTO People VALUES ( NULL, "]] .. people[i].FirstName .. [[","]] 
																	.. people[i].LastName .. [[","]] 
																	.. people[i].Gender .. [[","]] 
																	.. people[i].Sex .. [[","]] 
																	.. people[i].Birthdate .. [[","]] 
																	.. people[i].Hobby .. [[","]] 
																	.. people[i].Email .. [[","]] 
																	.. people[i].PersonType .. [[","]]
																	.. people[i].Username .. [[","]]
																	.. people[i].Password .. [[" );]]
					db:exec( q )
				end
	
				tpeople = {}
				sqldb.LoadDataFromTables()
				sqldb.CloseDatabase()
	
				firstNameRTextField.text = ""
				lastNameRTextField.text = ""
				genderRTextField.text = ""
				sexRTextField.text = ""
				birthdateRTextField.text = ""
				hobbyRTextField.text = ""
				emailRTextField.text = ""
				personTypeRTextField.text = ""
				usernameRTextField.text = ""
				passwordRTextField.text = ""
				local alert = native.showAlert( "Registration Successful", "You are now a FriendFinder User!", {"OK"}, onComplete )	
			end
		end	
	end

	local moreRegistrationButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = moreRegistrationButtonEvent,
			x = display.contentCenterX,
			y = 455
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
			y = 455
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
			y = 455
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
	sceneGroup:insert( moreRegistrationButton )
	sceneGroup:insert( backButton )
	sceneGroup:insert( registerButton )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then


	elseif phase == "did" then
		usernameRTextField = native.newTextField( usernameRParams.x + 135, title.y + 40, 170, 35)
		usernameRTextField:setTextColor( 0 )
		usernameRTextField.isEditable = true
		usernameRTextField.size = 20
		usernameRTextField.text = ""

		passwordRTextField = native.newTextField( passwordRParams.x + 130, usernameRTextField.y + 39, 170, 35)
		passwordRTextField:setTextColor( 0 )
		passwordRTextField.isEditable = true
		passwordRTextField.size = 20
		passwordRTextField.isSecure = true
		passwordRTextField.text = ""

		firstNameRTextField = native.newTextField( firstNameParams.x + 116, passwordRTextField.y + 39, 170, 35)
		firstNameRTextField:setTextColor( 0 )
		firstNameRTextField.isEditable = true
		firstNameRTextField.size = 20
		firstNameRTextField.text = ""

		lastNameRTextField = native.newTextField( lastNameParams.x + 115, firstNameRTextField.y + 39, 170, 35)
		lastNameRTextField:setTextColor( 0 )
		lastNameRTextField.isEditable = true
		lastNameRTextField.size = 20
		lastNameRTextField.text = ""

		genderRTextField = native.newTextField( genderParams.x + 110, lastNameRTextField.y + 39, 170, 35)
		genderRTextField:setTextColor( 0 )
		genderRTextField.isEditable = true
		genderRTextField.size = 20
		genderRTextField.text = ""

		sexRTextField = native.newTextField( sexParams.x + 77, genderRTextField.y + 38, 170, 35)
		sexRTextField:setTextColor( 0 )
		sexRTextField.isEditable = true
		sexRTextField.size = 20
		sexRTextField.text = ""

		birthdateRTextField = native.newTextField( birthdateParams.x + 123, sexRTextField.y + 38, 170, 35)
		birthdateRTextField:setTextColor( 0 )
		birthdateRTextField.isEditable = true
		birthdateRTextField.size = 20
		birthdateRTextField.text = ""

		hobbyRTextField = native.newTextField( hobbyParams.x + 125, birthdateRTextField.y + 38, 170, 35)
		hobbyRTextField:setTextColor( 0 )
		hobbyRTextField.isEditable = true
		hobbyRTextField.size = 20
		hobbyRTextField.text = ""

		emailRTextField = native.newTextField( emailParams.x + 93, hobbyRTextField.y + 38, 170, 35)
		emailRTextField:setTextColor( 0 )
		emailRTextField.isEditable = true
		emailRTextField.size = 20
		emailRTextField.text = ""

		personTypeRTextField = native.newTextField( personTypeParams.x + 131, emailRTextField.y + 38, 170, 35)
		personTypeRTextField:setTextColor( 0 )
		personTypeRTextField.isEditable = true
		personTypeRTextField.size = 20
		personTypeRTextField.text = ""

		sceneGroup:insert( usernameRTextField )
		sceneGroup:insert( passwordRTextField )
		sceneGroup:insert( firstNameRTextField )
		sceneGroup:insert( lastNameRTextField )
		sceneGroup:insert( genderRTextField )
		sceneGroup:insert( sexRTextField )
		sceneGroup:insert( birthdateRTextField )
		sceneGroup:insert( hobbyRTextField )
		sceneGroup:insert( emailRTextField )
		sceneGroup:insert( personTypeRTextField )

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		usernameRTextField:removeSelf()
		usernameRTextField = nil
		
		passwordRTextField:removeSelf()
		passwordRTextField = nil
		
		firstNameRTextField:removeSelf()
		firstNameRTextField = nil
		
		lastNameRTextField:removeSelf()
		lastNameRTextField = nil
		
		genderRTextField:removeSelf()
		genderRTextField = nil
		
		sexRTextField:removeSelf()
		sexRTextField = nil
		
		birthdateRTextField:removeSelf()
		birthdateRTextField = nil
		
		hobbyRTextField:removeSelf()
		hobbyRTextField = nil
		
		emailRTextField:removeSelf()
		emailRTextField = nil
		
		personTypeRTextField:removeSelf()
        personTypeRTextField = nil

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