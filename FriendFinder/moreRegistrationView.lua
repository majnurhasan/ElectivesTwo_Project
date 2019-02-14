-----------------------------------------------------------------------------------------
--
-- moreRegistrationView.lua
--
-----------------------------------------------------------------------------------------
local composer = require "composer" 
local widget = require "widget"
local sqldb = require "sqldb"
local scene = composer.newScene()
thobbyRStack = {}
hobbyCounter = 1

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )

	function background:tap( event )
		native.setKeyboardFocus( nil )
	end
	
	titleOne = display.newText( "More Hobbies", display.contentCenterX, 25, native.systemFont, 30 )
	titleOne:setFillColor( 0 )
	
	titleTwo = display.newText( "Personal Description", display.contentCenterX, 150, native.systemFont, 30 )
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

	local function onLoginView( event )
	composer.gotoScene( "loginView" )
	end
	
	local function backButtonEvent( event )
 
		if ( event.phase == "ended" ) then
			onRegistrationView()
		end
	end

	local function addHobbyButtonEvent( event )
		if ( event.phase == "ended" ) then
			if (extraHobbymRTextField.text == "") 
				then
				local alert = native.showAlert( "Error", "Please fill in a hobby before adding.", {"OK"}, onComplete )
			else
				table.insert(thobbyRStack,extraHobbymRTextField.text)
				hobbyCounter = hobbyCounter + 1
				extraHobbymRTextField.text = ""
				local alert = native.showAlert( "Hobby added!", "This is now registered as your hobby.", {"OK"}, onComplete )	
			end
		end	
	end

	local function registerButtonEvent( event )
		if ( event.phase == "ended" ) then
			if ( personalDescriptionTextBox.text == "" ) 
				then
				local alert = native.showAlert( "Error", "Please fill in all empty details.", {"OK"}, onComplete )
			else
				print("Register Successful!")
				sqldb.OpenDatabase()
				local people = {
					{
						FirstName = tpersonRStack.FirstName,
						LastName = tpersonRStack.LastName,
						Gender = tpersonRStack.Gender,
						Sex  = tpersonRStack.Sex,
						Birthdate = tpersonRStack.Birthdate,
						Hobby = tpersonRStack.Hobby,
						Email = tpersonRStack.Email,
						PersonType = tpersonRStack.PersonType,
						Username = tpersonRStack.Username,
						Password = tpersonRStack.Password,
						PDescription = personalDescriptionTextBox.text
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
																	.. people[i].PDescription .. [[","]]
																	.. people[i].Username .. [[","]]
																	.. people[i].Password .. [[" );]]
					db:exec( q )
				end

				tpeople = {}
				sqldb.LoadDataFromTables()

				for i = 1,#thobbyRStack do
					local p = [[INSERT INTO Hobbies VALUES ( NULL, "]] .. thobbyRStack[i] .. [[","]] 
																	   .. tpeople[table.maxn(tpeople)].UserID .. [[" );]]
					db:exec( p )
				end
				
				thobbies = {}
				sqldb.LoadDataFromTables()

				sqldb.CloseDatabase()

				personalDescriptionTextBox.text = ""
				tpersonRStack = {}
				thobbyRStack = {}
				local alert = native.showAlert( "Registration Successful", "You are now a FriendFinder User!", {"OK"}, onComplete )	
				onLoginView()
			end
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

	local addHobbyButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = addHobbyButtonEvent,
			x = display.contentCenterX,
			y = 110
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
	sceneGroup:insert( titleOne )
	sceneGroup:insert( titleTwo )
	sceneGroup:insert( backButton )
	sceneGroup:insert( extraHobby )
	sceneGroup:insert( addHobbyButton )
	sceneGroup:insert( registerButton )

	background:addEventListener("tap", background)

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

		personalDescriptionTextBox = native.newTextBox( display.contentCenterX, 300, 250, 230)
		personalDescriptionTextBox.isEditable = true
		personalDescriptionTextBox.size = 16
		personalDescriptionTextBox.text = "Type your personal description here."

		sceneGroup:insert( extraHobbymRTextField )
		sceneGroup:insert( personalDescriptionTextBox )
		

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		extraHobbymRTextField:removeSelf()
		extraHobbymRTextField = nil
		
		personalDescriptionTextBox:removeSelf()
		personalDescriptionTextBox = nil
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