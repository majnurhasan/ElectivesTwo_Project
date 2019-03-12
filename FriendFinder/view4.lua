-----------------------------------------------------------------------------------------
--
-- view4.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()

--Variables
otherHobbyRowData = ""

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
	
	local title = display.newText( "Profile", display.contentCenterX, 0, native.systemFont, 32 )
	title:setFillColor( 0 )	

	local personalDescriptionPParams = { text = "\"" .. tloggedInUser.PDescription .. "\"", 
						x = display.contentCenterX, 
						y = title.y + 80, 
						width = 300, height = 100, 
						font = native.systemFontBold, fontSize = 20, 
						align = "center" }
	local personalDescriptionHeader = display.newText( personalDescriptionPParams )
	personalDescriptionHeader:setFillColor( 0 )

	local namePParams = { text = "Name: " .. tloggedInUser.FirstName .. " " .. tloggedInUser.LastName, 
						x = display.contentCenterX, 
						y = personalDescriptionPParams.y + 30, 
						width = 250, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local nameHeader = display.newText( namePParams )
	nameHeader:setFillColor( 0 )

	local genderAndSexPParams = { text = "Gender: " .. tloggedInUser.Gender .. "   " .. "Sex: " .. tloggedInUser.Sex, 
						x = display.contentCenterX, 
						y = namePParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local genderAndSexHeader = display.newText( genderAndSexPParams )
	genderAndSexHeader:setFillColor( 0 )

	local birthdatePParams = { text = "Birthdate: " .. tloggedInUser.Birthdate, 
						x = display.contentCenterX, 
						y = genderAndSexPParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local birthdateHeader = display.newText( birthdatePParams )
	birthdateHeader:setFillColor( 0 )

	local mainHobbyPParams = { text = "Main Hobby: " .. tloggedInUser.Hobby, 
						x = display.contentCenterX, 
						y = birthdatePParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local mainHobbyHeader = display.newText( mainHobbyPParams )
	mainHobbyHeader:setFillColor( 0 )


	local personTypePParams = { text = "Person Type: " .. tloggedInUser.PersonType, 
						x = display.contentCenterX, 
						y = mainHobbyPParams.y + 30, 
						width = 300, height = 50, 
						font = native.systemFont, fontSize = 20, 
						align = "center" }
	local personTypeHeader = display.newText( personTypePParams )
	personTypeHeader:setFillColor( 0 )

	local emailPParams = { text = "Email: " .. tloggedInUser.Email, 
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
	
		print(tloggedInUserHobbies[id])
		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
	
		local rowTitle = display.newText( row, tloggedInUserHobbies[id], 0, 0, nil, 14 )
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	local otherHobbiesTableView = widget.newTableView(
		{
			left = 30,
			top = 320,
			height = 150,
			width = 250,
			onRowRender = onRowRender,
			onRowTouch = onRowTouch,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(tloggedInUserHobbies), 1
		do
		otherHobbiesTableView:insertRow{}
	end

	

	local scrollView = widget.newScrollView
	{
		left = 0,
		top = 0,
		width = display.contentWidth,
		height =431,
		topPadding = 20,
		bottomPadding = 20,
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
	scrollView:insert( otherHobbiesTableView )


	sceneGroup:insert( background )
	sceneGroup:insert( tabBar )
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
