-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()
local sqldb = require "sqldb"

-- Special Variables
passedUserID = 0
nearbyPersonsStack = {}

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	
	
	local title = display.newText( "Friends Around You", display.contentCenterX, 30, native.systemFont, 32 )
	title:setFillColor( 0 )

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

	local nearbyPersonHobbyParams = { text = ":. Main Hobby .:", 
						x = display.contentCenterX, 
						y = title.y + 150, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local nearbyPersonHobby = display.newText( nearbyPersonHobbyParams )
	nearbyPersonHobby:setFillColor( 0 )

	local nearbyPersonHobbyContentParams = { text = tpeople[1].Hobby, 
						x = display.contentCenterX, 
						y = nearbyPersonHobbyParams.y + 30, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local nearbyPersonHobbyContent = display.newText( nearbyPersonHobbyContentParams )
	nearbyPersonHobbyContent:setFillColor( 0 )

	local function onNearbyPersonDetailsView( event )
		composer.gotoScene( "nearbyPersonView" )
	end

	local function sendWaveButtonEvent( event )
		if ( event.phase == "ended" ) then
			local latestID = 0
			sqldb.OpenDatabase()
			local wave = {
				{
					WaveDescription = "You seem awesome! Wanna hang out?",
					WaveDate = "Date: " ..  os.date( "%x" ) .. "  Time: " .. date.hour .. ":" .. date.min,
					WaveState = "1",
					UserID = tloggedInUser.UserID
				}
			}

			for i = 1,#wave do
				local q = [[INSERT INTO Waves VALUES ( NULL, "]] .. wave[i].WaveDescription .. [[","]] 
																.. wave[i].WaveDate .. [[","]] 
																.. wave[i].WaveState .. [[","]] 
																.. wave[i].UserID .. [[" );]]
				db:exec( q )
			end

			twaves = {}
			tloggedInUserWaves = {}
			sqldb.LoadDataFromTables()

			for i=1, table.maxn(twaves), 1
					do	
						latestID = latestID + 1
						if(tloggedInUser.UserID == twaves[i].UserID)
						then	
							table.insert(tloggedInUserWaves, twaves[i])
						end
			end

			local q = [[INSERT INTO People_Waves VALUES ("]]  		  .. selectedNearbyPerson.UserID .. [[","]]
															   		  .. latestID .. [[" );]]
			db:exec( q )

			sqldb.CloseDatabase()
			local alert = native.showAlert( "Wave Sent", "The person can know acknowledge your presence!", {"OK"}, onComplete )
		end
	end

	local function viewNearbyPersonDetailsButtonEvent( event )
		if ( event.phase == "ended" ) then
			onNearbyPersonDetailsView()
		end
	end

	local sendWaveButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = sendWaveButtonEvent,
			x = 70,
			y = nearbyPersonHobbyContentParams.y + 30
		}
	)

	local viewNearbyPersonDetailsButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = viewNearbyPersonDetailsButtonEvent,
			x = 250,
			y = nearbyPersonHobbyContentParams.y + 30
		}
	)
	function onRowRenderFive( event )
		local row = event.row
		local id = row.index

		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		
		local rowTitle = display.newText( row, tpeople[passedUserID].SignalLocation, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	function ShowDetailsForNearbyPeopleTableView( event )
		local row = event.target
   		local id = row.index 
		local counter = 0
		while(counter ~= id)
		do
			counter = counter + 1
		end
		
		for i=1, table.maxn(tpeople), 1
		do
			if(nearbyPersonsStack[counter] == tpeople[i].UserID)
			then
					selectedNearbyPerson = tpeople[i]
			end
		end

		nearbyPersonHobbyContent.text =  selectedNearbyPerson.Hobby  

		selectedNearbyPersonHobbies = {}
		selectedNearbyPersonEvents = {}
		selectedNearbyPersonHobbyGroups = {}
		for i=1, table.maxn(thobbies), 1
			do
				if(selectedNearbyPerson.UserID == thobbies[i].UserID)
				then	
					table.insert(selectedNearbyPersonHobbies, thobbies[i].HobbyName)
				end
		end	

		for i=1, table.maxn(tpeopleEvents), 1
			do
				if(selectedNearbyPerson.UserID == tpeopleEvents[i].UserID)
				then	
					table.insert(selectedNearbyPersonEvents, tpeopleEvents[i].EventID)
				end
		end

		for i=1, table.maxn(tpeopleHobbyGroups), 1
			do
				if(selectedNearbyPerson.UserID == tpeopleHobbyGroups[i].UserID)
				then	
					table.insert(selectedNearbyPersonHobbyGroups, tpeopleHobbyGroups[i].GroupID)
				end
		end

    	return true
	end

	local nearbyPeopleTableView = widget.newTableView(
		{
			left = 30,
			top = title.y + 30,
			height = 80,
			width = 250,
			onRowRender = onRowRenderFive,
			onRowTouch = ShowDetailsForNearbyPeopleTableView,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(tpeople), 1
	do
		if(tpeople[i].SignalLocation ~= "none" and tpeople[i].UserID ~= tloggedInUser.UserID) 
		then
			passedUserID = i
			table.insert(nearbyPersonsStack,i)
			nearbyPeopleTableView:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end
	end

	newSignalLocationtitle = display.newText( "Signal-Ur-Location", display.contentCenterX, sendWaveButton.y + 78, native.systemFont, 32 )
	newSignalLocationtitle:setFillColor( 0 )

	local function updateLocationButtonEvent( event )
		if ( event.phase == "ended" ) then
			sqldb.OpenDatabase()
			local q1 = "UPDATE People SET SignalLocation=\"" .. signalLocationTextField.text .. "\" WHERE UserID=" .. tloggedInUser.UserID .. ";"
			db:exec( q1 )
			sqldb.CloseDatabase()
			
			signalLocationTextField.text = ""
			local alert = native.showAlert( "Signal Sent", "You have sucessfully logged where you're at!", {"OK"}, onComplete )
		end
	end

	local updateLocationButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = updateLocationButtonEvent,
			x = display.contentCenterX,
			y = newSignalLocationtitle.y + 95
		}
	)

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( tabBar )
	sceneGroup:insert( nearbyPeopleTableView )
	sceneGroup:insert( nearbyPersonHobby )
	sceneGroup:insert( nearbyPersonHobbyContent )
	sceneGroup:insert( sendWaveButton )
	sceneGroup:insert( viewNearbyPersonDetailsButton )
	sceneGroup:insert( newSignalLocationtitle )
	sceneGroup:insert( updateLocationButton	 )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then
		signalLocationTextField = native.newTextField( display.contentCenterX, newSignalLocationtitle.y + 50, 250, 35)
		signalLocationTextField:setTextColor( 0 )
		signalLocationTextField.isEditable = true
		signalLocationTextField.size = 20
		signalLocationTextField.isSecure = false

		sceneGroup:insert( signalLocationTextField )

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		signalLocationTextField:removeSelf()
        signalLocationTextField = nil
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