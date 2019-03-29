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
	
	nPtitle = display.newText( "Person Details:", display.contentCenterX, 0, native.systemFont, 32 )
	nPtitle:setFillColor( 0 )	

	local otherHobbiesTitle = display.newText( "Other Hobbies", display.contentCenterX, 250 + 40, native.systemFont, 32 )
	otherHobbiesTitle:setFillColor( 0 )	

	local eventsTitle = display.newText( "Events Attended", display.contentCenterX, 355 + 80, native.systemFont, 32 )
	eventsTitle:setFillColor( 0 )	

	local hobbyGroupsTitle = display.newText( "Hobby Groups", display.contentCenterX, 495 + 80, native.systemFont, 32 )
	hobbyGroupsTitle:setFillColor( 0 )	

	local function onFirstView( event )
		composer.gotoScene( "view1" )
	end 

	local function backButtonEvent( event )
		if ( event.phase == "ended" ) then
			onFirstView()
		end
	end

	scrollnPView = widget.newScrollView
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

	scrollnPView:insert( nPtitle )
	scrollnPView:insert( otherHobbiesTitle )
	scrollnPView:insert( eventsTitle )
	scrollnPView:insert( hobbyGroupsTitle )

	local backButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = backButtonEvent,
			x = display.contentCenterX,
			y = display.contentHeight - 28
		}
	)
	
	sceneGroup:insert( background )
	sceneGroup:insert( scrollnPView )
	sceneGroup:insert( backButton )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		local personalDescriptionnPParams = { text = "\"" .. selectedNearbyPerson.PDescription .. "\"", 
							x = display.contentCenterX, 
							y = nPtitle.y + 80, 
							width = 300, height = 100, 
							font = native.systemFontBold, fontSize = 20, 
							align = "center" }
		personalDescriptionnPHeader = display.newText( personalDescriptionnPParams )
		personalDescriptionnPHeader:setFillColor( 0 )

		local namenPParams = { text = "Name: " .. selectedNearbyPerson.FirstName .. " " .. selectedNearbyPerson.LastName, 
							x = display.contentCenterX, 
							y = personalDescriptionnPParams.y + 30, 
							width = 250, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		namenPHeader = display.newText( namenPParams )
		namenPHeader:setFillColor( 0 )

		local genderAndSexnPParams = { text = "Gender: " .. selectedNearbyPerson.Gender .. "   " .. "Sex: " .. selectedNearbyPerson.Sex, 
							x = display.contentCenterX, 
							y = namenPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		genderAndSexnPHeader = display.newText( genderAndSexnPParams )
		genderAndSexnPHeader:setFillColor( 0 )

		local birthdatenPParams = { text = "Birthdate: " .. selectedNearbyPerson.Birthdate, 
							x = display.contentCenterX, 
							y = genderAndSexnPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		birthdatenPHeader = display.newText( birthdatenPParams )
		birthdatenPHeader:setFillColor( 0 )

		local mainHobbynPParams = { text = "Main Hobby: " .. selectedNearbyPerson.Hobby, 
							x = display.contentCenterX, 
							y = birthdatenPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		mainHobbynPHeader = display.newText( mainHobbynPParams )
		mainHobbynPHeader:setFillColor( 0 )


		local personTypenPParams = { text = "Person Type: " .. selectedNearbyPerson.PersonType, 
							x = display.contentCenterX, 
							y = mainHobbynPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		personTypenPHeader = display.newText( personTypenPParams )
		personTypenPHeader:setFillColor( 0 )

		local emailnPParams = { text = "Email: " .. selectedNearbyPerson.Email, 
							x = display.contentCenterX, 
							y = personTypenPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		emailnPHeader = display.newText( emailnPParams )
		emailnPHeader:setFillColor( 0 )

		function onRowRendernP( event )
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
	
		otherHobbiesTableViewnP = widget.newTableView(
			{
				left = 30,
				top = 320,
				height = 80,
				width = 250,
				onRowRender = onRowRendernP,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedNearbyPersonHobbies), 1
			do
			otherHobbiesTableViewnP:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end

		function onRowRenderTwonP( event )
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
	
		eventsAttendedTableViewnP = widget.newTableView(
			{
				left = 30,
				top = 460,
				height = 80,
				width = 250,
				onRowRender = onRowRenderTwonP,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedNearbyPersonEvents), 1
			do
			eventsAttendedTableViewnP:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end

		function onRowRenderThreenP( event )
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
	
		hobbyGroupsTableViewnP = widget.newTableView(
			{
				left = 30,
				top = 600,
				height = 80,
				width = 250,
				onRowRender = onRowRenderThreenP,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedNearbyPersonHobbyGroups), 1
		do
				hobbyGroupsTableViewnP:insertRow({
					isCategory = false,
					rowHeight = 36,
					rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
					lineColor = { 0.5, 0.5, 0.5 }
				})
		end

		scrollnPView:insert( otherHobbiesTableViewnP )
		scrollnPView:insert( eventsAttendedTableViewnP )
		scrollnPView:insert( hobbyGroupsTableViewnP )
		scrollnPView:insert( personalDescriptionnPHeader )
		scrollnPView:insert( namenPHeader )
		scrollnPView:insert( genderAndSexnPHeader )
		scrollnPView:insert( birthdatenPHeader )
		scrollnPView:insert( mainHobbynPHeader )
		scrollnPView:insert( personTypenPHeader )
		scrollnPView:insert( emailnPHeader )

	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		selectedNearbyPersonHobbies = {}
		selectedNearbyPersonEvents = {}
		selectedNearbyPersonHobbyGroups = {}
		personalDescriptionnPHeader:removeSelf()
		namenPHeader:removeSelf()
		genderAndSexnPHeader:removeSelf()
		birthdatenPHeader:removeSelf()
		mainHobbynPHeader:removeSelf()
		personTypenPHeader:removeSelf()
		emailnPHeader:removeSelf()
		otherHobbiesTableViewnP:removeSelf()
		eventsAttendedTableViewnP:removeSelf()
		hobbyGroupsTableViewnP:removeSelf()
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
