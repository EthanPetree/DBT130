/***********************************************************************/
/************************************************************************
	3A: Nebula Command Protocol - Engage the CRUD Core (GalacticDepot)
		
				****	Mission Directives	****

************************************************************************/
/************************************************************************
Welcome, Cadet! 

Your journey begins on Nebula 7, where you've been tasked with establishing 
an operational outpost for space exploration. Your mission is to design, 
populate, and manage a secure database for the brave 
explorers embarking on this cosmic journey.

In this mission, you will create and manage a database that tracks 
critical crew information, perform CRUD (Create, Read, Update, Delete) operations, 
and demonstrate your ability to manipulate and safeguard data. 

You will then transfer to the Galactic Depot, the central hub supplying space 
explorers across the galaxy, where you'll restore and manage a production-grade database.

By completing this mission, you will:
	*- Understand the foundational operations of a relational database.
	*- Design and create a normalized database to support space exploration missions.
	*- Write and execute SQL queries to manage data effectively.
	*- Explore backup and restoration processes essential for disaster recovery.

Instructions:
	- Work individually. Do all your work in the GalacticDepot database.
	- Complete all work within this file. 
		- Part 1 uses the Nebula7Mission1 database. 
		- Part 2 uses the GalacticDepot database
	- Each query that you create should be placed directly below its task.
	- Do not paste query results into this file unless explicitly requested.
	- Submit your completed .sql file to Canvas by the deadline.
	- JOIN Syntax: Use JOIN ON syntax unless explicitly instructed 
		to use CROSS JOIN or COMMA style.
	- All responses are SQL queries unless otherwise specified.

******************************************************************************/

/*******************************************************************************
			            PART 1: Nebula 7 Mission 1
			    In this section, you'll create a database
			   for a mission to an unknown outpost in space.
********************************************************************************/

/* Task 1: Create a Database
   Create a database called Nebula7Mission1.
   Enter your SQL script to create the database below in the white space.
*/
USE master
GO

DROP DATABASE IF EXISTS Nebula7Mission1
GO

CREATE DATABASE Nebula7Mission1
GO


/* Task 2: Prepare for Operations
   Switch to your newly created Nebula7Mission1 database.
   Enter the command to switch database context.
*/

USE Nebula7Mission1
GO


/* Task 3: Establish Crew Quarters
   Add a table called Explorers to the database with the following columns: 
   - ExplorersID - number (can not be empty)
   - FirstName - text (can not be empty)
   - LastName - text (can not be empty)
   - BirthDate - date
   - Phone - phone numbers (with special characters)
   - Address - text and numbers
   - City - text
   - State - text
   - ZipCode - numbers and characters
   
   Use appropriate data types for each field.
*/

CREATE TABLE Explorers
(
   ExplorersID SMALLINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   FirstName VARCHAR(30) NOT NULL,
   LastName VARCHAR(30) NOT NULL,
   BirthDate DATE NULL,
   Phone VARCHAR(15) NULL,
   Address VARCHAR(40) NULL,
   City VARCHAR(20) NULL,
   State VARCHAR(20) NULL,
   ZipCode VARCHAR(10) NULL
)



/* Task 4: Crew Registration
   Add at least three explorers of your choice to the Explorers table.
   Populate all columns for each person with realistic data.
*/
INSERT Explorers (FirstName, LastName, BirthDate, Phone, Address, City, State, ZipCode)
   VALUES ('Arthur', 'Dent', '1985-04-12', '(555) 123-4567', '42 Hitchhiker Lane', 'Seattle', 'WA', '98101-1122'),
   ('Ellen', 'Ripley', '1979-11-20', '555-987-6543', '101 Nostromo Ave', 'Houston', 'TX', '77001'),
   ('James', 'Holden', '1992-02-08', '1-800-555-0199', '500 Rocinante Way', 'Salt Lake City', 'UT', '84101')



/* Task 5: Crew Manifest
   Return all explorers in the Explorers table.
*/

SELECT * FROM Explorers;



/* Task 6: Data Correction
   Mission Control reports an error in one explorer's planetary code.
   Use an UPDATE statement to change one of the explorer's planetary code (ZIP) to 84111.
*/

UPDATE Explorers
SET ZipCode = '84111'
WHERE ExplorersID = 1;



/* Task 7: Verification Check
   Confirm your update worked by returning only the row
   for the explorer whose data you just corrected.
   Use appropriate WHERE conditions.
*/

Select *
FROM Explorers
WHERE ExplorersID = 1;



/* Task 8: Crew Reassignment
   One explorer has been reassigned to another mission.
   Delete the row for this reassigned explorer.
*/


DELETE FROM Explorers
   WHERE ExplorersID = 2;


/* Task 9: Final Crew Check
   Verify the remaining explorers are still in the database
   with a SELECT statement.
*/

SELECT * FROM Explorers;


/* Task 10: Mission Reset
   Urgent message from Command: 
   Nebula 7 - Mission 1 has been terminated!
   All personnel must be removed from the Mission Manifest.
   Remove all remaining explorers from the Explorers table.
*/

DELETE FROM Explorers;

/* Task 11: [WRITTEN RESPONSE]
   Run a SELECT on the now-empty Explorers table.
   What exactly is returned when querying an empty table?
   (Describe the result structure, not just "nothing")
*/

SELECT * FROM Explorers;
-- The table structure doesn't even show any table structure, but the collumns are still there.



/* Task 12: Decommission Quarters
   Remove the Explorers table from the Nebula7Mission1 database.
*/

DROP TABLE Explorers;


/* Task 13: [WRITTEN RESPONSE]
   Now try selecting from the non-existent Explorers table.
   What error message is returned? Be specific about the system's response.
*/

SELECT * FROM Explorers;
-- It says invalid object name, so it won't even let you try

/* Task 14: Decommission Nebula 7 - Mission 1
   Remove the Nebula7Mission1 database from your system.
*/

USE master
GO
DROP DATABASE IF EXISTS Nebula7Mission1;



/***************************************************************************
****************************************************************************

			            PART 2: EXPEDITION NEBULA 7
				  You've been reassigned to the Nebula Outpost.
			   Restore the GalacticDepot database to your system
						and complete your new mission tasks.

*****************************************************************************
*****************************************************************************/

/* *** NOTE: YOU SHOULD ALREADY HAVE THE GALACTICDEPOT 
				DATABASE ON YOUR SYSTEM, SKIP AHEAD IF TRUE.
			IF NOT, COMPLETE THIS TASK TO RESTORE THE DATABASE
*/


/* Task 15: Restore the  Database
   Restore the GalacticDepot database from the provided GalacticDepot.bak file.
   Write the RESTORE DATABASE command you used.
   
   Note: The exact path will depend on your system configuration.
*/

-- Restore the database
USE master
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'GalacticDepot')
BEGIN
    RESTORE DATABASE GalacticDepot
    FROM DISK = N'C:\SQL_Backups\GalacticDepot.bak'
    WITH REPLACE
    PRINT 'Database restored successfully.'
END
ELSE
BEGIN
    PRINT 'Database "GalacticDepot" already exists. Restore skipped.'
END
GO

/* Task 16: Main Outpost Connection
   Change contexts to the GalacticDepot database.
*/

USE GalacticDepot
GO



/* Task 17: Database Reconnaissance
   List all tables in the GalacticDepot database.
   Hint: Use the INFORMATION_SCHEMA.TABLEs view.

*/

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES


/* Task 18: Sector Crew Analysis
   Return all crew members who originate from Sector7 (aka 'Australia').
   List their first and last name, job title, hire date, city and country. 
   Look at the Employees table to find the right field for filtering.
*/


SELECT FirstName, LastName, JobTitle, HireDate, City, Country
FROM Employees
WHERE Country = 'Australia'


/* Task 19: New Recruit Registration
   Add yourself as a new crew member to the Employees table.
   Assign yourself with the JobTitle of "Database Specialist".
   
   NOTE: Examine the table carefully to understand required fields and constraints.
   HINT: Do not specify an EmployeeID. Let IDENTITY assign the ID for you
*/


INSERT INTO Employees(FirstName, LastName, JobTitle)
VALUES ('Ethan', 'Petree', 'Database Specialist')
GO



/* Task 20: Supply Inventory
   List all supplies where the in-stock quantity is less than 10.
   Only show the product's ID, the name of the product, and the	in-stock quantity
   Examine the Products table first to understand its structure.
*/

SELECT ProductID, ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock < 10


/* Task 21: Inventory Update
   Update the Products table to increase the quantity 
   of "Cryo-Sleep Chamber" by 5 units.
*/


UPDATE Products
   SET UnitsInStock += 5
   WHERE ProductName = 'Cryo-Sleep Chamber'


/* Task 22: Verify the Inventory Update
   Verify the Inventory change is correct by 
   modifying the WHERE clause of the previous SELECT statement.
   Show only the product that was updated.
*/

SELECT ProductID, ProductName, UnitsInStock
FROM Products
WHERE ProductName = 'Cryo-Sleep Chamber' 



/* Task 23: [WRITTEN RESPONSE]
   Describe at least two different methods you can use to discover
   a table's definition (data types, key fields, NULL constraints, etc.)
   Be specific about the commands or tools you would use.
*/

/*
You can use a select on INFORMATION_SCHEMA.COLUMNS to get values like the datatype
or for checking if a field is nullable you can use the WHERE and is_nullable with the scheme.tables 
*/



/* Task 24: [WRITTEN RESPONSE]
   What are the advantages and disadvantages of requiring a field
   in a table to be "NOT NULL"? Consider both technical implications
   and business rules in your answer.
*/


/*
Not allowing a field to be null means that you guarantee that the field will recieve a value,
so you don't have to do as much data validation. This is especially important for IDs,
or a price value so it can be listed properly.
A disadvantage of this is that it could create errors if you incorrectly format an insert or update method.
*/



/*****************************************************************
                END OF ASSIGNMENT
	Ensure all your SQL statements are correct and executable.
	Double-check your [WRITTEN RESPONSE] answers are thorough.
	Save and Submit this completed SQL script file.
******************************************************************/