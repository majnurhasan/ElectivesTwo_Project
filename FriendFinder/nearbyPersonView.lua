-----------------------------------------------------------------------------------------
--
-- nearbyPersonView.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()
local globalFunctions = require "globalFunctions"

--Variables


function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )
	
	local title = display.newText( "Person Details:", display.contentCenterX, 0, native.systemFont, 32 )
	title:setFillColor( 0 )	

	local personalDescriptionPParams = { text = "\"" .. selectedNearbyPerson.PDescription .. "\"", 
						x = display.contentCenterX, 
						y = title.y + 80, 
						width = 300, height = 100, 
						font = native.systemFontBold, fontSize = 20, 
						align = "center" }
	local personalDescriptionHeader = display.newText( personalDescriptionPParams )
	personalDescriptionHeader:setFillColor( 0 )

	local namePParams = { text = "Name: " .. selectedNearbyPerson.FirstName .. " " .. selectedNearbyPerson.LastName, 
						x = display.contentCenterX, 
						y = personalDescriptionPParams.y + 30, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local nameHeader = display.newText( namePParams )
	nameHeader:setFillColor( 0 )

	local genderAndSexPParams = { text = "Gender: " .. selectedNearbyPerson.Gender .. "   " .. "Sex: " .. selectedNearbyPerson.Sex, 
						x = display.contentCenterX, 
						y = namePParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local genderAndSexHeader = display.newText( genderAndSexPParams )
	genderAndSexHeader:setFillColor( 0 )

	local birthdatePParams = { text = "Birthdate: " .. selectedNearbyPerson.Birthdate, 
						x = display.contentCenterX, 
						y = genderAndSexPParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local birthdateHeader = display.newText( birthdatePParams )
	birthdateHeader:setFillColor( 0 )

	local mainHobbyPParams = { text = "Main Hobby: " .. selectedNearbyPerson.Hobby, 
						x = display.contentCenterX, 
						y = birthdatePParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local mainHobbyHeader = display.newText( mainHobbyPParams )
	mainHobbyHeader:setFillColor( 0 )


	local personTypePParams = { text = "Person Type: " .. selectedNearbyPerson.PersonType, 
						x = display.contentCenterX, 
						y = mainHobbyPParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local personTypeHeader = display.newText( personTypePParams )
	personTypeHeader:setFillColor( 0 )

	local emailPParams = { text = "Email: " .. selectedNearbyPerson.Email, 
						x = display.contentCenterX, 
						y = personTypePParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local emailHeader = display.newText( emailPParams )
	emailHeader:setFillColor( 0 )

	local otherHobbiesTitle = display.newText( "Other Hobbies", display.contentCenterX, emailPParams.y + 40, native.systemFont, 32 )
	otherHobbiesTitle:setFillColor( 0 )	

	function onRowRender( event )
		local row = event.row
		local id = row.index

		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
	
		local rowTitle = display.newText( row, selectedNearbyPersonHobbies[id], 0, 0, nil, 14 )
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	local otherHobbiesTableView = widget.newTableView(
		{
			left = 30,
			top = 320,
			height = 80,
			width = 250,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(selectedNearbyPersonHobbies), 1
		do
		otherHobbiesTableView:insertRow{}
	end

	local eventsTitle = display.newText( "Events Attended", display.contentCenterX, otherHobbiesTableView.y + 80, native.systemFont, 32 )
	eventsTitle:setFillColor( 0 )	

	function onRowRenderTwo( event )
		local row = event.row
		local id = row.index
	
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		local rowEventTitle = ""
		for i=1, table.maxn(tevents), 1
			do
				if(selectedNearbyPersonEvents[id] == tevents[i].EventID)
				then
					rowEventTitle = tevents[i].EventName
				end
		end

		local rowTitle = display.newText( row, rowEventTitle, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	local eventsAttendedTableView = widget.newTableView(
		{
			left = 30,
			top = 460,
			height = 80,
			width = 250,
			onRowRender = onRowRenderTwo,
			onRowTouch = onRowTouch,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(selectedNearbyPersonEvents), 1
		do
		eventsAttendedTableView:insertRow{}
	end

	local hobbyGroupsTitle = display.newText( "Hobby Groups", display.contentCenterX, eventsAttendedTableView.y + 80, native.systemFont, 32 )
	hobbyGroupsTitle:setFillColor( 0 )	

	function onRowRenderThree( event )
		local row = event.row
		local id = row.index
	
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		local rowEventTitle = ""
		for i=1, table.maxn(tgroups), 1
			do
				if(selectedNearbyPersonHobbyGroups[id] == tgroups[i].GroupID)
				then
					rowEventTitle = tgroups[i].GroupName
				end
		end

		local rowTitle = display.newText( row, rowEventTitle, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	local hobbyGroupsTableView = widget.newTableView(
		{
			left = 30,
			top = 600,
			height = 80,
			width = 250,
			onRowRender = onRowRenderThree,
			onRowTouch = onRowTouch,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(selectedNearbyPersonHobbyGroups), 1
	do
			hobbyGroupsTableView:insertRow{}
	end

	local function backButtonEvent( event )
		if ( event.phase == "ended" ) then
			print("Back to View1")
		end
	end


	local backButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = backButtonEvent,
			x = display.contentCenterX,
			y = 710
		}
	)

	local scrollView = widget.newScrollView
	{
		left = 0,
		top = 0,
		width = display.contentWidth,
		height =431,
		topPadding = 30,
		bottomPadding = 30,
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false
	}

	scrollView:insert( title )
	scrollView:insert( personalDescriptionHeader )
	scrollView:insert( nameHeader )
	scrollView:insert( genderAndSexHeader )
	scrollView:insert( birthdateHeader )
	scrollView:insert( mainHobbyHeader )
	scrollView:insert( personTypeHeader )
	scrollView:insert( emailHeader )
	scrollView:insert( otherHobbiesTitle )
	scrollView:insert( eventsTitle )
	scrollView:insert( hobbyGroupsTitle )
	scrollView:insert( otherHobbiesTableView )
	scrollView:insert( eventsAttendedTableView )
	scrollView:insert( hobbyGroupsTableView )
	scrollView:insert( backButton )
	
	sceneGroup:insert( background )
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
