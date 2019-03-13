-----------------------------------------------------------------------------------------
--
-- view3.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()

--Variables

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	
	
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
	
	local title = display.newText( "Hobby Groups", display.contentCenterX, 30, native.systemFont, 32 )
	title:setFillColor( 0 )	

	function onRowRenderFour( event )
		local row = event.row
		local id = row.index
	
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth

		local rowTitle = display.newText( row, tgroups[id].GroupName, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	local hobbyGroupsGTableView = widget.newTableView(
		{
			left = 30,
			top = title.y + 30,
			height = 120,
			width = 250,
			onRowRender = onRowRenderFour,
			onRowTouch = onRowTouch,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(tgroups), 1
	do
		hobbyGroupsGTableView:insertRow{}
	end

	local groupNameGParams = { text = ":. Hobby Group Name .:", 
						x = display.contentCenterX, 
						y = hobbyGroupsGTableView.y + 100, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local groupNameGHeader = display.newText( groupNameGParams )
	groupNameGHeader:setFillColor( 0 )

	local groupNameContentGParams = { text = "insert group name here", 
						x = display.contentCenterX, 
						y = groupNameGParams.y + 30, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local groupNameContentGHeader = display.newText( groupNameContentGParams )
	groupNameContentGHeader:setFillColor( 0 )

	local groupDesriptionGParams = { text = ":. Description .:", 
						x = display.contentCenterX, 
						y = groupNameContentGParams.y + 50, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local groupDescriptionGHeader = display.newText( groupDesriptionGParams )
	groupDescriptionGHeader:setFillColor( 0 )

	local groupDesriptionContentGParams = { text = "insert group description here insert group description here insert group description here", 
						x = display.contentCenterX, 
						y = groupDesriptionGParams.y + 50, 
						width = 300, height = 80, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local groupDescriptionContentGHeader = display.newText( groupDesriptionContentGParams )
	groupDescriptionContentGHeader:setFillColor( 0 )

	local function sendRequestToJoinGroupButtonEvent( event )
		if ( event.phase == "ended" ) then
			print("Request to join group sent")
		end
	end

	local function seeGroupHeldEventsButtonEvent( event )
		if ( event.phase == "ended" ) then
			print("Events View will Show")
		end
	end

	local sendRequestToJoinGroupButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = sendRequestToJoinGroupButtonEvent,
			x = 70,
			y = groupDesriptionContentGParams.y + 58
		}
	)

	local seeGroupHeldEventsButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = seeGroupHeldEventsButtonEvent,
			x = 250,
			y = groupDesriptionContentGParams.y + 58
		}
	)
	

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( tabBar )
	sceneGroup:insert( hobbyGroupsGTableView )
	sceneGroup:insert( groupNameGHeader )
	sceneGroup:insert( groupNameContentGHeader )
	sceneGroup:insert( groupDescriptionGHeader )
	sceneGroup:insert( groupDescriptionContentGHeader )
	sceneGroup:insert( sendRequestToJoinGroupButton )
	sceneGroup:insert( seeGroupHeldEventsButton )
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
