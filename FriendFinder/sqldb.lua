-----------------------------------------------------------------------------------------
--
-- sqldb.lua
--
-----------------------------------------------------------------------------------------
local sqlite3 = require( "sqlite3" )
local M = {}

local function OpenDatabase()
	local path = system.pathForFile( "friendfinderdata.db", system.DocumentsDirectory )
	local db = sqlite3.open( path )
end

local function InitializeTables()
	local peopleTableSetup = [[CREATE TABLE IF NOT EXISTS People ( UserID INTEGER PRIMARY KEY autoincrement,
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

	local hobbiesTableSetup = [[CREATE TABLE IF NOT EXISTS Hobbies ( HobbyID INTEGER PRIMARY KEY autoincrement,
																							Name, 
																							UserID INTEGER,
																							FOREIGN KEY(UserID) REFERENCES People(UserID));]]
	db:exec( hobbiesTableSetup )

	local hobbyGroupsTableSetup = [[CREATE TABLE IF NOT EXISTS HobbyGroups ( GroupID INTEGER PRIMARY KEY autoincrement,
																							Name);]]
	db:exec( hobbyGroupsTableSetup )

	local peopleHobbyGroupSetup = [[CREATE TABLE IF NOT EXISTS People_HobbyGroups ( GroupID INTEGER,
																							UserID INTEGER,
																							FOREIGN KEY(GroupID) REFERENCES HobbyGroups(GroupID),
																							FOREIGN KEY(UserID) REFERENCES People(UserID),);]]
	db:exec( peopleHobbyGroupSetup )
end



local function LoadDataFromPeopleTable()

end


local function CloseDatabase()
	if ( db and db:isopen() ) then
		db:close()
	end
end


M.InitializeTables = InitializeTables

return M




