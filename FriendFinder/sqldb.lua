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
																							Username, 
																							Password);]]
	db:exec( peopleTableSetup )

	local hobbiesTableSetup = [[CREATE TABLE IF NOT EXISTS Hobbies ( HobbyID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
																							HobbyName, 
																							UserID INTEGER NOT NULL,
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( hobbiesTableSetup )

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
				Username = "jsmith",
				Password = "jsmith4ever"
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
				Username = "majx804",
				Password = "412maj612"
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
				Username = "freshofftheboat",
				Password = "ehuang123"
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
															 .. people[i].Username .. [[","]]
															 .. people[i].Password .. [[" );]]
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
				GroupName = "SCoD: Sewing Club of Davao",
				NumberOfPeople = 0,
				Description = "Sewing lovers, come join now!"
			},
			{
				GroupName = "Interschool Volleyball Society",
				NumberOfPeople = 0,
				Description = "Groups of volleyball lovers and enthusiasts from different schools."
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

	-- create initial data for other tables soon
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
			Username = row.Username,
			Password = row.Password
		}
		peopleCounter = peopleCounter + 1
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

	hobbyGroupsCounter = 0;
	for row in db:nrows( "SELECT * FROM HobbyGroups" ) do
		tgroups[#tgroups+1] =
		{
			GroupID = row.GroupID,
			GroupName = row.GroupName
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




