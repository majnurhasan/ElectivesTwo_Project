-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require "composer" 
local widget = require "widget"
local scene = composer.newScene()
local sqldb = require "sqldb"

-- Special Variables
passedWaveID = 0
interestedWaveID = 0
wavePersonStack = {}
interestedPersonStack = {}
latestID2 = 0

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
	
	local title = display.newText( "Waves Received", display.contentCenterX, 30, native.systemFont, 32 )
	title:setFillColor( 0 )	

	function onRowRenderSix( event )
		local row = event.row
		local id = row.index

		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		local rowName = ""
		
		for i=1, table.maxn(tpeople), 1
		do
			if(twaves[passedWaveID].UserID == tpeople[i].UserID)
			then
				rowName = tpeople[i].FirstName .. " " .. tpeople[i].LastName
			end
		end

		local rowTitle = display.newText( row, rowName, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	function ShowWavesReceivedDetails( event )
		local row = event.target
   		local id = row.index 
		local counter = 0
		while(counter ~= id)
		do
			counter = counter + 1
		end
		   for i=1, table.maxn(twaves), 1
		   do
			   if(wavePersonStack[counter] == twaves[i].WaveID)
			   then
					selectedWave = twaves[i]
					  for j=1, table.maxn(tpeople), 1
					  do
						if(twaves[i].UserID == tpeople[j].UserID)
						then
							selectedWavePerson = tpeople[j]
						end
					  end
			   end
		   end 
   
		   selectedWavePersonHobbies = {}
		   selectedWavePersonEvents = {}
		   selectedWavePersonHobbyGroups = {}
		   for i=1, table.maxn(thobbies), 1
			   do
				   if(selectedWavePerson.UserID == thobbies[i].UserID)
				   then	
					   table.insert(selectedWavePersonHobbies, thobbies[i].HobbyName)
				   end
		   end	
		   
   
		   for i=1, table.maxn(tpeopleEvents), 1
			   do
				   if(selectedWavePerson.UserID == tpeopleEvents[i].UserID)
				   then	
					   table.insert(selectedWavePersonEvents, tpeopleEvents[i].EventID)
				   end
		   end
		   print(selectedWavePersonEvents[1])
   
		   for i=1, table.maxn(tpeopleHobbyGroups), 1
			   do
				   if(selectedWavePerson.UserID == tpeopleHobbyGroups[i].UserID)
				   then	
					   table.insert(selectedWavePersonHobbyGroups, tpeopleHobbyGroups[i].GroupID)
				   end
		   end
    	return true
	end

	local wavesReceivedTableView = widget.newTableView(
		{
			left = 30,
			top = title.y + 30,
			height = 80,
			width = 250,
			onRowRender = onRowRenderSix,
			onRowTouch = ShowWavesReceivedDetails,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(tpeopleWaves), 1
	do
		if(tpeopleWaves[i].UserID == tloggedInUser.UserID)
		then
			for j=1, table.maxn(twaves), 1
			do
				if(tpeopleWaves[i].WaveID == twaves[j].WaveID)
				then
					if(twaves[j].WaveState == "1")
					then
						passedWaveID = i
						table.insert(wavePersonStack,i)
						wavesReceivedTableView:insertRow({
							isCategory = false,
							rowHeight = 36,
							rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
							lineColor = { 0.5, 0.5, 0.5 }
						})
					end
				end
			end
		end
	end
	
	local function onWavePersonDetailsView()
		composer.gotoScene("wavePersonView")
	end


	local function waveBackButtonEvent (event)
		if ( event.phase == "ended" ) then
			local latestID2 = 0
			sqldb.OpenDatabase()
			local wave = {
				{
					WaveDescription = "You also seem like a cool person, let's meet where you're at right now.",
					WaveDate = "Date: " ..  os.date( "%x" ) .. "  Time: " .. date.hour .. ":" .. date.min,
					WaveState = "2",
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
			sqldb.LoadDataFromTables()
			tloggedInUserWaves = {}
			tpeopleWaves = {}
			

			for i=1, table.maxn(twaves), 1
					do	
						latestID2 = latestID2 + 1
						if(tloggedInUser.UserID == twaves[i].UserID)
						then	
							table.insert(tloggedInUserWaves, twaves[i])
						end
			end

			local q = [[INSERT INTO People_Waves VALUES ("]]  		  .. selectedWavePerson.UserID .. [[","]]
															   		  .. latestID2 .. [[" );]]
			db:exec( q )

			sqldb.LoadDataFromTables()
			sqldb.CloseDatabase()
			local alert = native.showAlert( "Wave Confirmed", "You waved back and is interested with the person!", {"OK"}, onComplete )
		end
	end

	local function seeWaveDetailsButtonEvent (event)
			onWavePersonDetailsView()
	end

	local function moveHeadSidewaysButtonEvent (event)
			latestID2 = 0
			sqldb.OpenDatabase()
			local wave = {
				{
					WaveDescription = "You're cool and all, but I'm not interested.",
					WaveDate = "Date: " ..  os.date( "%x" ) .. "  Time: " .. date.hour .. ":" .. date.min,
					WaveState = "3",
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
			sqldb.LoadDataFromTables()
			tloggedInUserWaves = {}
			tpeopleWaves = {}
			

			for i=1, table.maxn(twaves), 1
					do	
						print(twaves[i].WaveID)
						latestID2 = latestID2 + 1
						if(tloggedInUser.UserID == twaves[i].UserID)
						then	
							table.insert(tloggedInUserWaves, twaves[i])
						end
			end
			print(latestID2)

			local q = [[INSERT INTO People_Waves VALUES ("]]  		  .. selectedWavePerson.UserID .. [[","]]
															   		  .. latestID2 .. [[" );]]
			db:exec( q )

			--sqldb.LoadDataFromTables()
			sqldb.CloseDatabase()
			local alert = native.showAlert( "Wave Confirmed", "You turn your head sideways, stating that you're not interested.", {"OK"}, onComplete )

	end


	local waveBackButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = waveBackButtonEvent,
			x = 70,
			y = wavesReceivedTableView.y + 70
		}
	)

	local seeWaveDetailsButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = seeWaveDetailsButtonEvent,
			x = display.contentCenterX,
			y = wavesReceivedTableView.y + 70
		}
	)

	local moveHeadSidewaysButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button1.png",
			overFile="button1-down.png",
			label = "",
			onEvent = moveHeadSidewaysButtonEvent,
			x = 250,
			y = wavesReceivedTableView.y + 70
		}
	)

	local interestedFriendsTitle = display.newText( "Interested Friends", display.contentCenterX, moveHeadSidewaysButton.y + 80, native.systemFont, 32 )
	interestedFriendsTitle:setFillColor( 0 )	

	function onRowRenderSeven( event )
		local row = event.row
		local id = row.index

		local rowHeight = row.contentHeight
		local rowWidth = row.contentWidth
		local rowName = ""
		
		for i=1, table.maxn(tpeople), 1
		do
			if(twaves[interestedWaveID].UserID == tpeople[i].UserID)
			then
				rowName = tpeople[i].FirstName .. " " .. tpeople[i].LastName
			end
		end

		local rowTitle = display.newText( row, rowName, 0, 0, nil, 14 )
		
		rowTitle:setFillColor( 0 )

		rowTitle.anchorX = 0
		rowTitle.x = 0
		rowTitle.y = rowHeight * 0.5
	end

	function ShowInterestedWavesDetails( event )
		local row = event.target
   		local id = row.index 
		local counter = 0
		while(counter ~= id)
		do
			counter = counter + 1
		end
		   for i=1, table.maxn(twaves), 1
		   do
			   if(interestedPersonStack[counter] == twaves[i].WaveID)
			   then
					selectedInterestedWave = twaves[i]
					  for j=1, table.maxn(tpeople), 1
					  do
						if(twaves[i].UserID == tpeople[j].UserID)
						then
							selectedInterestedWavePerson = tpeople[j]
						end
					  end
			   end
		   end 
   
		   selectedInterestedWavePersonHobbies = {}
		   selectedInterestedWavePersonEvents = {}
		   selectedInterestedWavePersonHobbyGroups = {}
		   for i=1, table.maxn(thobbies), 1
			   do
				   if(selectedInterestedWavePerson.UserID == thobbies[i].UserID)
				   then	
					   table.insert(selectedInterestedWavePersonHobbies, thobbies[i].HobbyName)
				   end
		   end	
   
		   for i=1, table.maxn(tpeopleEvents), 1
			   do
				   if(selectedInterestedWavePerson.UserID == tpeopleEvents[i].UserID)
				   then	
					   table.insert(selectedInterestedWavePersonEvents, tpeopleEvents[i].EventID)
				   end
		   end
   
		   for i=1, table.maxn(tpeopleHobbyGroups), 1
			   do
				   if(selectedInterestedWavePerson.UserID == tpeopleHobbyGroups[i].UserID)
				   then	
					   table.insert(selectedInterestedWavePersonHobbyGroups, tpeopleHobbyGroups[i].GroupID)
				   end
		   end
    	return true
	end

	local interestedWavesTableView = widget.newTableView(
		{
			left = 30,
			top = interestedFriendsTitle.y + 30,
			height = 80,
			width = 250,
			onRowRender = onRowRenderSeven,
			onRowTouch = ShowInterestedWavesDetails,
			listener = scrollListener
		}
	)

	for i=1, table.maxn(tpeopleWaves), 1
	do
		if(tpeopleWaves[i].UserID == tloggedInUser.UserID)
		then
			for j=1, table.maxn(twaves), 1
			do
				if(tpeopleWaves[i].WaveID == twaves[j].WaveID)
				then
					if(twaves[j].WaveState == "2")
					then
						interestedWaveID = i
						table.insert(interestedPersonStack,i)
						interestedWavesTableView:insertRow({
							isCategory = false,
							rowHeight = 36,
							rowColor = { default={1,1,1}, over={1,0.5,0,0.2} },
							lineColor = { 0.5, 0.5, 0.5 }
						})
					end
				end
			end
		end
	end

	local function onInterestedWavePersonDetailsView()
		composer.gotoScene("interestedWavePersonView")
	end

	local function seeInterestedWaveDetailsButtonEvent (event)
		onInterestedWavePersonDetailsView()
	end


	local seeInterestedWaveDetailsButton = widget.newButton(
		{
			width = 40,
			height = 40	,
			defaultFile="button2.png",
			overFile="button2-down.png",
			label = "",
			onEvent = seeInterestedWaveDetailsButtonEvent,
			x = display.contentCenterX,
			y = interestedWavesTableView.y + 70
		}
	)
	

	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( interestedFriendsTitle )
	sceneGroup:insert( tabBar )
	sceneGroup:insert( wavesReceivedTableView )
	sceneGroup:insert( waveBackButton )
	sceneGroup:insert( seeWaveDetailsButton )
	sceneGroup:insert( moveHeadSidewaysButton )
	sceneGroup:insert( interestedWavesTableView )
	sceneGroup:insert( seeInterestedWaveDetailsButton )
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
