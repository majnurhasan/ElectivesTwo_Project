-----------------------------------------------------------------------------------------
--
-- interestedWavePersonView.lua
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
	
	iWtitle = display.newText( "Person Details:", display.contentCenterX, 0, native.systemFont, 32 )
	iWtitle:setFillColor( 0 )	

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

	scrolliWView = widget.newScrollView
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

	scrolliWView:insert( iWtitle )
	scrolliWView:insert( otherHobbiesTitle )
	scrolliWView:insert( eventsTitle )
	scrolliWView:insert( hobbyGroupsTitle )

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
	sceneGroup:insert( scrolliWView )
	sceneGroup:insert( backButton )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		local personalDescriptioniiWarams = { text = "\"" .. selectedInterestedWavePerson.PDescription .. "\"", 
							x = display.contentCenterX, 
							y = iWtitle.y + 80, 
							width = 300, height = 100, 
							font = native.systemFontBold, fontSize = 20, 
							align = "center" }
		personalDescriptioniWHeader = display.newText( personalDescriptioniiWarams )
		personalDescriptioniWHeader:setFillColor( 0 )

		local nameiiWarams = { text = "Name: " .. selectedInterestedWavePerson.FirstName .. " " .. selectedInterestedWavePerson.LastName, 
							x = display.contentCenterX, 
							y = personalDescriptioniiWarams.y + 30, 
							width = 250, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		nameiWHeader = display.newText( nameiiWarams )
		nameiWHeader:setFillColor( 0 )

		local genderAndSexiiWarams = { text = "Gender: " .. selectedInterestedWavePerson.Gender .. "   " .. "Sex: " .. selectedInterestedWavePerson.Sex, 
							x = display.contentCenterX, 
							y = nameiiWarams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		genderAndSexiWHeader = display.newText( genderAndSexiiWarams )
		genderAndSexiWHeader:setFillColor( 0 )

		local birthdateiiWarams = { text = "Birthdate: " .. selectedInterestedWavePerson.Birthdate, 
							x = display.contentCenterX, 
							y = genderAndSexiiWarams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		birthdateiWHeader = display.newText( birthdateiiWarams )
		birthdateiWHeader:setFillColor( 0 )

		local mainHobbyiiWarams = { text = "Main Hobby: " .. selectedInterestedWavePerson.Hobby, 
							x = display.contentCenterX, 
							y = birthdateiiWarams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		mainHobbyiWHeader = display.newText( mainHobbyiiWarams )
		mainHobbyiWHeader:setFillColor( 0 )


		local personTypeiiWarams = { text = "Person Type: " .. selectedInterestedWavePerson.PersonType, 
							x = display.contentCenterX, 
							y = mainHobbyiiWarams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		personTypeiWHeader = display.newText( personTypeiiWarams )
		personTypeiWHeader:setFillColor( 0 )

		local emailiiWarams = { text = "Email: " .. selectedInterestedWavePerson.Email, 
							x = display.contentCenterX, 
							y = personTypeiiWarams.y + 30, 
							width = 300, height = 50, 
							font = native.systemFont, fontSize = 20, 
							align = "center" }
		emailiWHeader = display.newText( emailiiWarams )
		emailiWHeader:setFillColor( 0 )

		function onRowRenderiW( event )
			local row = event.row
			local id = row.index
	
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
		
			local rowTitle = display.newText( row, selectedInterestedWavePersonHobbies[id], 0, 0, nil, 14 )
			rowTitle:setFillColor( 0 )
	
			rowTitle.anchorX = 0
			rowTitle.x = 0
			rowTitle.y = rowHeight * 0.5
		end
	
		otherHobbiesTableViewiW = widget.newTableView(
			{
				left = 30,
				top = 320,
				height = 80,
				width = 250,
				onRowRender = onRowRenderiW,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedInterestedWavePersonHobbies), 1
			do
			otherHobbiesTableViewiW:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end

		function onRowRenderTwoiW( event )
			local row = event.row
			local id = row.index
		
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
			local rowEventTitle = ""
			for i=1, table.maxn(tevents), 1
				do
					if(selectedInterestedWavePersonEvents[id] == tevents[i].EventID)
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
	
		eventsAttendedTableViewiW = widget.newTableView(
			{
				left = 30,
				top = 460,
				height = 80,
				width = 250,
				onRowRender = onRowRenderTwoiW,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedInterestedWavePersonEvents), 1
			do
			eventsAttendedTableViewiW:insertRow({
				isCategory = false,
				rowHeight = 36,
				rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
				lineColor = { 0.5, 0.5, 0.5 }
			})
		end

		function onRowRenderThreeiW( event )
			local row = event.row
			local id = row.index
		
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
			local rowEventTitle = ""
			for i=1, table.maxn(tgroups), 1
				do
					if(selectedInterestedWavePersonHobbyGroups[id] == tgroups[i].GroupID)
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
	
		hobbyGroupsTableViewiW = widget.newTableView(
			{
				left = 30,
				top = 600,
				height = 80,
				width = 250,
				onRowRender = onRowRenderThreeiW,
				onRowTouch = onRowTouch,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(selectedInterestedWavePersonHobbyGroups), 1
		do
				hobbyGroupsTableViewiW:insertRow({
					isCategory = false,
					rowHeight = 36,
					rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
					lineColor = { 0.5, 0.5, 0.5 }
				})
		end

		scrolliWView:insert( otherHobbiesTableViewiW )
		scrolliWView:insert( eventsAttendedTableViewiW )
		scrolliWView:insert( hobbyGroupsTableViewiW )
		scrolliWView:insert( personalDescriptioniWHeader )
		scrolliWView:insert( nameiWHeader )
		scrolliWView:insert( genderAndSexiWHeader )
		scrolliWView:insert( birthdateiWHeader )
		scrolliWView:insert( mainHobbyiWHeader )
		scrolliWView:insert( personTypeiWHeader )
		scrolliWView:insert( emailiWHeader )

	elseif phase == "did" then

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		selectedInterestedWavePersonHobbies = {}
		selectedInterestedWavePersonEvents = {}
		selectedInterestedWavePersonHobbyGroups = {}
		personalDescriptioniWHeader:removeSelf()
		nameiWHeader:removeSelf()
		genderAndSexiWHeader:removeSelf()
		birthdateiWHeader:removeSelf()
		mainHobbyiWHeader:removeSelf()
		personTypeiWHeader:removeSelf()
		emailiWHeader:removeSelf()
		otherHobbiesTableViewiW:removeSelf()
		eventsAttendedTableViewiW:removeSelf()
		hobbyGroupsTableViewiW:removeSelf()
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
