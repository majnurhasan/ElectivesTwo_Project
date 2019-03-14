-----------------------------------------------------------------------------------------
--
-- eventsView.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()

--Variables
local thobbyGroupEvents = {}



function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	
	
	titleForEventView = display.newText( "Events Held", display.contentCenterX, 30, native.systemFont, 32 )
	titleForEventView:setFillColor( 0 )	

	eventsETableViewVerticalPlacement = titleForEventView.y + 30

	local eventNameEParams = { text = ":. Event Name .:", 
						x = display.contentCenterX, 
						y = eventsETableViewVerticalPlacement + 160, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local eventNameEHeader = display.newText( eventNameEParams )
	eventNameEHeader:setFillColor( 0 )

	local eventNameContentEParams = { text = "", 
						x = display.contentCenterX, 
						y = eventNameEParams.y + 30, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	eventNameContentEHeader = display.newText( eventNameContentEParams )
	eventNameContentEHeader:setFillColor( 0 )

	local eventVenueEParams = { text = ":. Event Venue .:", 
						x = display.contentCenterX, 
						y = eventNameContentEParams.y + 40, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local eventVenueEHeader = display.newText( eventVenueEParams )
	eventVenueEHeader:setFillColor( 0 )

	local eventVenueContentEParams = { text = "", 
						x = display.contentCenterX, 
						y = eventVenueEParams.y + 30, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	eventVenueContentEHeader = display.newText( eventVenueContentEParams )
	eventVenueContentEHeader:setFillColor( 0 )

	local eventDescriptionEParams = { text = ":. Details .:", 
						x = display.contentCenterX, 
						y = eventVenueContentEParams.y + 40, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local eventDescriptionEHeader = display.newText( eventDescriptionEParams )
	eventDescriptionEHeader:setFillColor( 0 )

	local eventDescriptionContentEParams = { text = "", 
						x = display.contentCenterX, 
						y = eventDescriptionEParams.y + 45, 
						width = 300, height = 80, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	eventDescriptionContentEHeader = display.newText( eventDescriptionContentEParams )
	eventDescriptionContentEHeader:setFillColor( 0 )

	local function onView3( event )
		composer.gotoScene( "view3" )
	end
	
	local function backToHobbyGroupsViewButtonEvent( event )
		if ( event.phase == "ended" ) then
			onView3()
		end
	end

	local backToHobbyGroupsViewButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = backToHobbyGroupsViewButtonEvent,
			x = display.contentCenterX,
			y = eventDescriptionContentEParams.y + 50
		}
	)
	

	sceneGroup:insert( background )
	sceneGroup:insert( titleForEventView )
	sceneGroup:insert( eventNameEHeader )
	sceneGroup:insert( eventVenueEHeader )
	sceneGroup:insert( eventDescriptionEHeader )
	sceneGroup:insert( eventNameContentEHeader )
	sceneGroup:insert( eventVenueContentEHeader )
	sceneGroup:insert( eventDescriptionContentEHeader )
	sceneGroup:insert( backToHobbyGroupsViewButton )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then

	elseif phase == "did" then
		for i=1, table.maxn(tevents), 1
		do
			if(selectedGroup.GroupID == tevents[i].GroupID)
			then	
				table.insert(thobbyGroupEvents, tevents[i])
			end
		end

		function onRowRenderFive( event )
			local row = event.row
			local id = row.index
		
			local rowHeight = row.contentHeight
			local rowWidth = row.contentWidth
	
			local rowTitle = display.newText( row, thobbyGroupEvents[id].EventName, 0, 0, nil, 14 )
			
			rowTitle:setFillColor( 0 )
	
			rowTitle.anchorX = 0
			rowTitle.x = 0
			rowTitle.y = rowHeight * 0.5
		end
	
		function ShowEventDetailsOfSelectedGroup( event )
			local row = event.target
			local id = row.index 
			
			eventNameContentEHeader.text =  thobbyGroupEvents[id].EventName  
			eventVenueContentEHeader.text = thobbyGroupEvents[id].EventVenue
			eventDescriptionContentEHeader.text = thobbyGroupEvents[id].EventDetails
			return true
		end
	
		eventsETableView = widget.newTableView(
			{
				left = 30,
				top = titleForEventView.y + 30,
				height = 120,
				width = 250,
				onRowRender = onRowRenderFive,
				onRowTouch = ShowEventDetailsOfSelectedGroup,
				listener = scrollListener
			}
		)
	
		for i=1, table.maxn(thobbyGroupEvents), 1
		do
			eventsETableView:insertRow{}
		end

		sceneGroup:insert( eventsETableView )
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		thobbyGroupEvents = {}
		eventsETableView:removeSelf()
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
