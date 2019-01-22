-----------------------------------------------------------------------------------------
--
-- sqldb.lua
--
-----------------------------------------------------------------------------------------

-- Require the SQLite library
local sqlite3 = require( "sqlite3" )
 
-- Create a file path for the database file "data.db"
local path = system.pathForFile( "friendfinderdata.db", system.DocumentsDirectory )
 
-- Open the database for access
local db = sqlite3.open( path )

-- Setup for the a table called test
local tableSetup = [[CREATE TABLE IF NOT EXISTS People ( UserID INTEGER PRIMARY KEY autoincrement,
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
db:exec( tableSetup )

-- Collection of data inserted to the table
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
        FirstName = "Tricia",
		LastName = "Cole",
		Gender = "Straight",
		Sex  = "Female",
		Birthdate = "05/25/2002",
		Hobby = "Makeup",
		Email = "coolgirl433@gmail.com",
		PersonType = "Extrovert",
		Username = "barbiedoll",
		Password = "123kenismybfriend"
    }
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

-- Sample update syntax
local q2 = [[UPDATE test SET FirstName="Trisha" WHERE UserID=3;]]
db:exec( q2 )

-- Sample delete syntax
local q3 = [[DELETE FROM test WHERE UserID=1;]]
db:exec( q3 )

-- Sample retrieve syntax

--[[ Create empty "people" table
local people = {}
 
-- Loop through database table rows via a SELECT query
for row in db:nrows( "SELECT * FROM test" ) do
 
    print( "Row:", row.UserID )
 
    -- Create sub-table at next available index of "people" table
    people[#people+1] =
    {
        FirstName = row.FirstName,
        LastName = row.LastName
    }
end]]

-- Close the database when finish using
if ( db and db:isopen() ) then
    db:close()
end




