-----------------------------------------------------------------------------------------
--
-- sqldb.lua
--
-----------------------------------------------------------------------------------------
local dbCommands = {}

local function OpenDatabase()
	local path = system.pathForFile( "friendfinderdata.db", system.DocumentsDirectory )
	db = sqlite3.open( path )
end

local function InitializeTables()
	local peopleTableSetup = [[CREATE TABLE IF NOT EXISTS People ( UserID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							FirstName,
																							LastName, 
																							Gender, 
																							Sex, 
																							Birthdate, 
																							Hobby, 
																							Email, 
																							PersonType,
																							PDescription, 
																							Username, 
																							Password,
																							SignalLocation);]]
	db:exec( peopleTableSetup )

	local hobbiesTableSetup = [[CREATE TABLE IF NOT EXISTS Hobbies ( HobbyID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							HobbyName, 
																							UserID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( hobbiesTableSetup )

	local wavesTableSetup = [[CREATE TABLE IF NOT EXISTS Waves ( WaveID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							WaveDescription, 
																							WaveDate,
																							WaveState,
																							UserID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( wavesTableSetup )

	local rwavesTableSetup = [[CREATE TABLE IF NOT EXISTS RWaves ( RWaveID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							RWaveStatus, 
																							RWaveDate,
																							RWaveState,
																							UserID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( rwavesTableSetup )

	local hobbyGroupsTableSetup = [[CREATE TABLE IF NOT EXISTS HobbyGroups ( GroupID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							GroupName,
																							NumberOfPeople,
																							Description);]]
	db:exec( hobbyGroupsTableSetup )

	local eventsTableSetup = [[CREATE TABLE IF NOT EXISTS Events ( EventID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							EventName, 
																							EventDetails,
																							EventVenue,
																							EventParticipants INTEGER,
																							GroupID INTEGER NOT NULL,
																							FOREIGN KEY(GroupID) REFERENCES HobbyGroups(GroupID));]]
	db:exec( eventsTableSetup )

	local peopleHobbyGroupSetup = [[CREATE TABLE IF NOT EXISTS People_HobbyGroups ( GroupID INTEGER NOT NULL,
																							UserID INTEGER NOT NULL,
																							FOREIGN KEY(GroupID) REFERENCES HobbyGroups(GroupID),
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( peopleHobbyGroupSetup )

	local peopleEventSetup = [[CREATE TABLE IF NOT EXISTS People_Events ( EventID INTEGER NOT NULL,
																							UserID INTEGER NOT NULL,
																							FOREIGN KEY(EventID) REFERENCES Events(EventID),
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( peopleEventSetup )

	local peopleFriendsSetup = [[CREATE TABLE IF NOT EXISTS People_Friends ( UserID INTEGER NOT NULL,
																							FriendID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID),
																							FOREIGN KEY(FriendID) REFERENCES People(UserID));]]
	db:exec( peopleFriendsSetup )

	local peopleFriendsSetup = [[CREATE TABLE IF NOT EXISTS People_Friends ( UserID INTEGER NOT NULL,
																							FriendID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID),
																							FOREIGN KEY(FriendID) REFERENCES People(UserID));]]
	db:exec( peopleFriendsSetup )

	local peopleWavesSetup = [[CREATE TABLE IF NOT EXISTS People_Waves ( UserID INTEGER NOT NULL,
																							WaveID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID),
																							FOREIGN KEY(WaveID) REFERENCES Waves(WaveID));]]
	db:exec( peopleWavesSetup )

	local peopleRWavesSetup = [[CREATE TABLE IF NOT EXISTS People_RWaves ( UserID INTEGER NOT NULL,
																							RWaveID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID),
																							FOREIGN KEY(RWaveID) REFERENCES RWaves(RWaveID));]]
	db:exec( peopleRWavesSetup )

	
end

local function ConstructInitialDataInTables()
	if peopleCounter == 0 then
		local people = {
			{
				FirstName = "John",
				LastName = "Smith",
				Gender = "Straight",
				Sex  = "Male",
				Birthdate = "12/03/1990",
				Hobby = "Hiking",
				Email = "jsmith@gmail.com",
				PersonType = "Extrovert",
				PDescription = "My name is John but I'm not your ordinary John.",
				Username = "jsmith",
				Password = "jsmith4ever",
				SignalLocation = "MTS, Keepsakes"
			},
			{
				FirstName = "Majdi",
				LastName = "Nurhasan",
				Gender = "Gay",
				Sex  = "Male",
				Birthdate = "11/19/1998",
				Hobby = "FF XIV",
				Email = "majnurhasan@gmail.com",
				PersonType = "Ambivert",
				PDescription = "I literally like FF XIV, let's do duty runs together",
				Username = "majx804",
				Password = "412maj612",
				SignalLocation = "Ateneo Roxas"
			},
			{
				FirstName = "Emery",
				LastName = "Huang",
				Gender = "Straight",
				Sex  = "Male",
				Birthdate = "03/21/1998",
				Hobby = "Acting",
				Email = "ehuang@gmail.com",
				PersonType = "Extrovert",
				PDescription = "Let's be friends, genuinely.",
				Username = "freshofftheboat",
				Password = "ehuang123",
				SignalLocation = "Chinatown"
			},
		}
		
		for i = 1,#people do
			local q = [[INSERT INTO People VALUES ( NULL, "]] .. people[i].FirstName .. [[","]] 
															 .. people[i].LastName .. [[","]] 
															 .. people[i].Gender .. [[","]] 
															 .. people[i].Sex .. [[","]] 
															 .. people[i].Birthdate .. [[","]] 
															 .. people[i].Hobby .. [[","]] 
															 .. people[i].Email .. [[","]] 
															 .. people[i].PersonType .. [[","]]
															 .. people[i].PDescription .. [[","]]
															 .. people[i].Username .. [[","]]
															 .. people[i].Password .. [[","]]
															 .. people[i].SignalLocation .. [[" );]]
			db:exec( q )
		end
	else
		print("tpeople are not inserted with values")
	end

	if hobbiesCounter == 0 then
		local hobbies = {
			{
				HobbyName = "Reading",
				UserID = 1
			},
			{
				HobbyName = "Writing Novels",
				UserID = 2
			},
			{
				HobbyName = "Tinkering",
				UserID = 2
			},
			{
				HobbyName = "Volleyball",
				UserID = 3
			},
			{
				HobbyName = "Karate",
				UserID = 3
			},
		}

		for i = 1,#hobbies do
			local q = [[INSERT INTO Hobbies VALUES ( NULL, "]] .. hobbies[i].HobbyName .. [[","]]  
															   .. hobbies[i].UserID .. [[" );]]
			db:exec( q )
		end
	else
		print("thobbies are not inserted with values")
	end

	if hobbyGroupsCounter == 0 then
		local groups = {
			{
				GroupName = "HCoD: Hiking Club of Davao",
				NumberOfPeople = 1,
				Description = "Hiking lovers, come join now!"
			},
			{
				GroupName = "Interschool Volleyball Society",
				NumberOfPeople = 1,
				Description = "Groups of volleyball lovers and enthusiasts from different schools."
			},
			{
				GroupName = "Fallen Seraphim FC: Davao Branch",
				NumberOfPeople = 1,
				Description = "A branch extension of Fallen Seraphim here in Davao for FFXIV Players. "
			},
		}
		
		for i = 1,#groups do
			local q = [[INSERT INTO HobbyGroups VALUES ( NULL, "]]  .. groups[i].GroupName .. [[","]]
																	.. groups[i].NumberOfPeople .. [[","]]
																	.. groups[i].Description .. [[" );]]
			db:exec( q )
		end
	else
		print("tgroups are not inserted with values")
	end

	if eventsCounter == 0 then
		local events = {
			{
				EventName = "Hike Drill: Session One",
				EventDetails = "Conditioning exercises for the upcoming grand hike!",
				EventVenue = "Ateneo de Davao Sports Complex",
				EventParticipants = 1,
				GroupID = 1
			},
			{
				EventName = "42nd Faculty Volleyball Tournament",
				EventDetails = "Tournament organized by different volleyball school secs for their coaches and teachers.",
				EventVenue = "UIC Volleyball Court",
				EventParticipants = 1,
				GroupID = 2
			},
			{
				EventName = "Treasure Hunt: Expedition Five",
				EventDetails = "Gold mining event for the FC, officers please attend.",
				EventVenue = "Treasure Map Locations",
				EventParticipants = 1,
				GroupID = 3
			},
			{
				EventName = "Hide and Seek in Eorzean Areas",
				EventDetails = "FC Social Event, feel free to participate and earn prizes!",
				EventVenue = "FC House in Lavender Beds",
				EventParticipants = 1,
				GroupID = 3
			},
			{
				EventName = "Sigmascape Raid Runs",
				EventDetails = "Latest content run for Stormblood Expansion, meetup at FC House.",
				EventVenue = "Omega's Lair",
				EventParticipants = 1,
				GroupID = 3
			},
		}
		
		for i = 1,#events do
			local q = [[INSERT INTO Events VALUES ( NULL, "]]  .. events[i].EventName .. [[","]]
															   .. events[i].EventDetails .. [[","]]
															   .. events[i].EventVenue .. [[","]]
															   .. events[i].EventParticipants .. [[","]]
															   .. events[i].GroupID .. [[" );]]
			db:exec( q )
		end
	else
		print("tevents are not inserted with values")
	end

	if peopleEventsCounter == 0 then
		local peopleEvents = {
			{
				EventID = 1,
				UserID = 1,
			},
			{
				EventID = 2,
				UserID = 3,
			},
			{
				EventID = 3,
				UserID = 2,
			},
		}
		for i = 1,#peopleEvents do
			local q = [[INSERT INTO People_Events VALUES ("]]  		  .. peopleEvents[i].EventID .. [[","]]
															   		  .. peopleEvents[i].UserID .. [[" );]]
			db:exec( q )
		end
	else
		print("tpeopleEvents are not inserted with values")
	end

	if peopleHobbyGroupsCounter == 0 then
		local peopleHobbyGroups = {
			{
				GroupID = 1,
				UserID = 1,
			},
			{
				GroupID = 2,
				UserID = 3,
			},
			{
				GroupID = 3,
				UserID = 2,
			},
		}
		for i = 1,#peopleHobbyGroups do
			local q = [[INSERT INTO People_HobbyGroups VALUES ("]]  		  .. peopleHobbyGroups[i].GroupID .. [[","]]
															   		 		  .. peopleHobbyGroups[i].UserID .. [[" );]]
			db:exec( q )
		end
	else
		print("tpeopleHobbyGroups are not inserted with values")
	end
end

local function LoadDataFromTables()
	peopleCounter = 0;
	for row in db:nrows( "SELECT * FROM People" ) do
		tpeople[#tpeople+1] =
		{
			UserID = row.UserID,
			FirstName = row.FirstName,
			LastName = row.LastName,
			Gender = row.Gender,
			Sex = row.Sex,
			Birthdate = row.Birthdate,
			Hobby = row.Hobby,
			Email = row.Email,
			PersonType = row.PersonType,
			PDescription = row.PDescription,
			Username = row.Username,
			Password = row.Password,
			SignalLocation = row.SignalLocation
		}
		peopleCounter = peopleCounter + 1
	end

	eventsCounter = 0;
	for row in db:nrows( "SELECT * FROM Events" ) do
		tevents[#tevents+1] =
		{
			EventID = row.EventID,
			EventName = row.EventName,
			EventDetails = row.EventDetails,
			EventVenue = row.EventVenue,
			EventParticipants = row.EventParticipants,
			GroupID = row.GroupID
		}
		eventsCounter = eventsCounter + 1
	end

	hobbiesCounter = 0;
	for row in db:nrows( "SELECT * FROM Hobbies" ) do
		thobbies[#thobbies+1] =
		{
			HobbyID = row.HobbyID,
			HobbyName = row.HobbyName,
			UserID = row.UserID
		}
		hobbiesCounter = hobbiesCounter + 1
	end

	wavesCounter = 0;
	for row in db:nrows( "SELECT * FROM Waves" ) do
		twaves[#twaves+1] =
		{
			WaveID = row.WaveID,
			WaveDescription = row.WaveDescription,
			WaveDate = row.WaveDate,
			WaveState = row.WaveState,
			UserID = row.UserID
		}
		wavesCounter = wavesCounter + 1
	end

	rwavesCounter = 0;
	for row in db:nrows( "SELECT * FROM RWaves" ) do
		twaves[#twaves+1] =
		{
			RWaveID = row.RWaveID,
			RWaveStatus = row.RWaveStatus,
			RWaveDate = row.RWaveDate,
			RWaveState = row.RWaveState,
			UserID = row.UserID
		}
		wavesCounter = wavesCounter + 1
	end

	hobbyGroupsCounter = 0;
	for row in db:nrows( "SELECT * FROM HobbyGroups" ) do
		tgroups[#tgroups+1] =
		{
			GroupID = row.GroupID,
			GroupName = row.GroupName,
			NumberOfPeople = row.NumberOfPeople,
			Description = row.Description,
		}
		hobbyGroupsCounter = hobbyGroupsCounter + 1
	end

	peopleHobbyGroupsCounter = 0;
	for row in db:nrows( "SELECT * FROM People_HobbyGroups" ) do
		tpeopleHobbyGroups[#tpeopleHobbyGroups+1] =
		{
			GroupID = row.GroupID,
			UserID = row.UserID
		}
		peopleHobbyGroupsCounter = peopleHobbyGroupsCounter + 1
	end

	peopleEventsCounter = 0;
	for row in db:nrows( "SELECT * FROM People_Events" ) do
		tpeopleEvents[#tpeopleEvents+1] =
		{
			EventID = row.EventID,
			UserID = row.UserID
		}
		peopleEventsCounter = peopleEventsCounter + 1
	end

	peopleFriendsCounter = 0;
	for row in db:nrows( "SELECT * FROM People_Friends" ) do
		tpeopleFriends[#tpeopleFriends+1] =
		{
			UserID = row.UserID,
			FriendID = row.FriendID
		}
		peopleFriendsCounter = peopleFriendsCounter + 1
	end

	peopleWavesCounter = 0;
	for row in db:nrows( "SELECT * FROM People_Waves" ) do
		tpeopleWaves[#tpeopleWaves+1] =
		{
			UserID = row.UserID,
			WaveID = row.WaveID
		}
		peopleWavesCounter = peopleWavesCounter + 1
	end

	peopleRWavesCounter = 0;
	for row in db:nrows( "SELECT * FROM People_RWaves" ) do
		tpeopleRWaves[#tpeopleRWaves+1] =
		{
			UserID = row.UserID,
			RWaveID = row.RWaveID
		}
		peopleRWavesCounter = peopleRWavesCounter + 1
	end
end

local function CloseDatabase()
	if ( db and db:isopen() ) then
		db:close()
	end
end

dbCommands.OpenDatabase = OpenDatabase
dbCommands.InitializeTables = InitializeTables
dbCommands.ConstructInitialDataInTables = ConstructInitialDataInTables
dbCommands.LoadDataFromTables = LoadDataFromTables
dbCommands.CloseDatabase = CloseDatabase


return dbCommands




