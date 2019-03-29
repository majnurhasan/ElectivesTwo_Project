-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()


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
						y = title.y + 190, 
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
			--send Wave here, enter to database
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

		local rowTitle = display.newText( row, tpeople[id].SignalLocation, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	function ShowDetailsForNearbyPeopleTableView( event )
		local row = event.target
   		local id = row.index 
		
		nearbyPersonHobbyContent.text =  tpeople[id].Hobby  

		selectedNearbyPerson = tpeople[id]

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
			height = 120,
			width = 250,
			onRowRender = onRowRenderFive,
			onRowTouch = ShowDetailsForNearbyPeopleTableView,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(tpeople), 1
	do
		if(tpeople[i].SignalLocation ~= "none" and tpeople[i].UserID == tloggedInUser.UserID) 
		then
			nearbyPeopleTableView:insertRow{}
		end
	end

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( tabBar )
	sceneGroup:insert( nearbyPeopleTableView )
	sceneGroup:insert( nearbyPersonHobby )
	sceneGroup:insert( nearbyPersonHobbyContent )
	sceneGroup:insert( sendWaveButton )
	sceneGroup:insert( viewNearbyPersonDetailsButton )
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