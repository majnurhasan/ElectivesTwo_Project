-----------------------------------------------------------------------------------------
--
-- wavePersonView.lua
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
	
	wPtitle = display.newText( "Person Details:", display.contentCenterX, 0, native.systemFont, 32 )
	wPtitle:setFillColor( 0 )	

	local otherHobbiesTitle = display.newText( "Other Hobbies", display.contentCenterX, 250 + 40, native.systemFont, 32 )
	otherHobbiesTitle:setFillColor( 0 )	

	local eventsTitle = display.newText( "Events Attended", display.contentCenterX, 355 + 80, native.systemFont, 32 )
	eventsTitle:setFillColor( 0 )	

	local hobbyGroupsTitle = display.newText( "Hobby Groups", display.contentCenterX, 495 + 80, native.systemFont, 32 )
	hobbyGroupsTitle:setFillColor( 0 )	

	local function onSecondView( event )
		composer.gotoScene( "view2" )
	end 

	local function backButtonEvent( event )
		if ( event.phase == "ended" ) then
			onSecondView()
		end
	end

	scrollwPView = widget.newScrollView
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

	scrollwPView:insert( wPtitle )
	scrollwPView:insert( otherHobbiesTitle )
	scrollwPView:insert( eventsTitle )
	scrollwPView:insert( hobbyGroupsTitle )

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
	sceneGroup:insert( scrollwPView )
	sceneGroup:insert( backButton )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		local personalDescriptionwPParams = { text = "\"" .. selectedWavePerson.PDescription .. "\"", 
							x = display.contentCenterX, 
							y = wPtitle.y + 80, 
							width = 300, height = 100, 
							font = native.systemFontBold, fontSize = 20, 
							align = "center" }
		personalDescriptionwPHeader = display.newText( personalDescriptionwPParams )
		personalDescriptionwPHeader:setFillColor( 0 )

		local namewPParams = { text = "Name: " .. selectedWavePerson.FirstName .. " " .. selectedWavePerson.LastName, 
							x = display.contentCenterX, 
							y = personalDescriptionwPParams.y + 30, 
							width = 250, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		namewPHeader = display.newText( namewPParams )
		namewPHeader:setFillColor( 0 )

		local genderAndSexwPParams = { text = "Gender: " .. selectedWavePerson.Gender .. "   " .. "Sex: " .. selectedWavePerson.Sex, 
							x = display.contentCenterX, 
							y = namewPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		genderAndSexwPHeader = display.newText( genderAndSexwPParams )
		genderAndSexwPHeader:setFillColor( 0 )

		local birthdatewPParams = { text = "Birthdate: " .. selectedWavePerson.Birthdate, 
							x = display.contentCenterX, 
							y = genderAndSexwPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		birthdatewPHeader = display.newText( birthdatewPParams )
		birthdatewPHeader:setFillColor( 0 )

		local mainHobbywPParams = { text = "Main Hobby: " .. selectedWavePerson.Hobby, 
							x = display.contentCenterX, 
							y = birthdatewPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		mainHobbywPHeader = display.newText( mainHobbywPParams )
		mainHobbywPHeader:setFillColor( 0 )


		local personTypewPParams = { text = "Person Type: " .. selectedWavePerson.PersonType, 
							x = display.contentCenterX, 
							y = mainHobbywPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		personTypewPHeader = display.newText( personTypewPParams )
		personTypewPHeader:setFillColor( 0 )

		local emailwPParams = { text = "Email: " .. selectedWavePerson.Email, 
							x = display.contentCenterX, 
							y = personTypewPParams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		emailwPHeader = display.newText( emailwPParams )
		emailwPHeader:setFillColor( 0 )

		function onRowRenderwP( event )
			local row = event.row
			local id = row.index
	
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
		
			print(selectedWavePersonHobbies[id])
			local rowTitle = display.newText( row, selectedWavePersonHobbies[id], 0, 0, nil, 14 )
			rowTitle:setFillColor( 0 )
	
			rowTitle.anchorX = 0
			rowTitle.x = 0
			rowTitle.y = rowHeight * 0.5
		end
	
		otherHobbiesTableViewwP = widget.newTableView(
			{
				left = 30,
				top = 320,
				height = 80,
				width = 250,
				onRowRender = onRowRenderwP,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedWavePersonHobbies), 1
			do
			otherHobbiesTableViewwP:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end

		function onRowRenderTwowP( event )
			local row = event.row
			local id = row.index
		
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
			local rowEventTitle = ""
			for i=1, table.maxn(tevents), 1
				do
					if(selectedWavePersonEvents[id] == tevents[i].EventID)
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
	
		eventsAttendedTableViewwP = widget.newTableView(
			{
				left = 30,
				top = 460,
				height = 80,
				width = 250,
				onRowRender = onRowRenderTwowP,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedWavePersonEvents), 1
			do
			eventsAttendedTableViewwP:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end

		function onRowRenderThreewP( event )
			local row = event.row
			local id = row.index
		
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
			local rowEventTitle = ""
			for i=1, table.maxn(tgroups), 1
				do
					if(selectedWavePersonHobbyGroups[id] == tgroups[i].GroupID)
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
	
		hobbyGroupsTableViewwP = widget.newTableView(
			{
				left = 30,
				top = 600,
				height = 80,
				width = 250,
				onRowRender = onRowRenderThreewP,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedWavePersonHobbyGroups), 1
		do
				hobbyGroupsTableViewwP:insertRow({
					isCategory = false,
					rowHeight = 36,
					rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
					lineColor = { 0.5, 0.5, 0.5 }
				})
		end

		scrollwPView:insert( otherHobbiesTableViewwP )
		scrollwPView:insert( eventsAttendedTableViewwP )
		scrollwPView:insert( hobbyGroupsTableViewwP )
		scrollwPView:insert( personalDescriptionwPHeader )
		scrollwPView:insert( namewPHeader )
		scrollwPView:insert( genderAndSexwPHeader )
		scrollwPView:insert( birthdatewPHeader )
		scrollwPView:insert( mainHobbywPHeader )
		scrollwPView:insert( personTypewPHeader )
		scrollwPView:insert( emailwPHeader )

	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		selectedWavePersonHobbies = {}
		selectedWavePersonEvents = {}
		selectedWavePersonHobbyGroups = {}
		personalDescriptionwPHeader:removeSelf()
		namewPHeader:removeSelf()
		genderAndSexwPHeader:removeSelf()
		birthdatewPHeader:removeSelf()
		mainHobbywPHeader:removeSelf()
		personTypewPHeader:removeSelf()
		emailwPHeader:removeSelf()
		otherHobbiesTableViewwP:removeSelf()
		eventsAttendedTableViewwP:removeSelf()
		hobbyGroupsTableViewwP:removeSelf()
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
