-----------------------------------------------------------------------------------------
--
-- sqldb.lua
--
-----------------------------------------------------------------------------------------

--[[sample call syntax
local utility = require "utility"

local anyVariable = utility.myAwesomeFunction1()
local myVariable1 = utility.getMyVariable1()

from: https://medium.com/hackthecode/make-a-common-utility-file-in-lua-corona-sdk-2ca4e9bce915 

to access other variables in lua files, simply make them global

from: https://stackoverflow.com/questions/10593464/how-to-pass-and-receive-value-in-lua-to-another-lua ]]

-- Require the SQLite library
local sqlite3 = require( "sqlite3" )
 
-- Create a file path for the database file "data.db"
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
 
-- Open the database for access
local db = sqlite3.open( path )

-- Setup for the a table called test
local tableSetup = [[CREATE TABLE IF NOT EXISTS test ( UserID INTEGER PRIMARY KEY autoincrement, FirstName, LastName, Gender, Sex, Birthdate, Hobby, Email, PersonType);]]
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
    },
    {
        FirstName = "James",
		LastName = "Nelson",
		Gender = "Straight",
		Sex  = "Male",
		Birthdate = "09/15/1998",
		Hobby = "FF 10",
		Email = "jnelson@gmail.com",
		PersonType = "Introvert",
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
    },
}
 

for i = 1,#people do
	local q1 = [[INSERT INTO test VALUES ( NULL, "]] .. people[i].FirstName .. [[","]] 
													 .. people[i].LastName .. [[","]] 
													 .. people[i].Gender .. [[","]] 
													 .. people[i].Sex .. [[","]] 
													 .. people[i].Birthdate .. [[","]] 
													 .. people[i].Hobby .. [[","]] 
													 .. people[i].Email .. [[","]] 
													 .. people[i].PersonType .. [[" );]]
    db:exec( q1 )
end

-- Sample update syntax
local q2 = [[UPDATE test SET FirstName="Trisha" WHERE UserID=3;]]
db:exec( q2 )

-- Sample delete syntax
local q = [[DELETE FROM test WHERE UserID=1;]]
db:exec( q )

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




