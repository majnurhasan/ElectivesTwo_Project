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


-- Close the database when finish using
if ( db and db:isopen() ) then
    db:close()
end




