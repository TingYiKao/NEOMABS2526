-- Create a table employee. emp_id is the primary key. 
---Variable types are INT, VARCHAR(40), VARCHAR(40), DATE, VARCHAR(1), INT, (INT, INT)
-- Because of data integrity issues, you have to add foreign keys later (super_id, branch_id)
CREATE TABLE Employee (
    EmployeeID INT NOT NULL UNIQUE,
    FirstName TEXT CHECK(length(FirstName) <= 40),
    LastName TEXT CHECK(length(LastName) <= 40),
    BirthDay Date,
    Sex TEXT CHECK(length(Sex) <= 1),
    Salary INT,
    PRIMARY KEY(EmployeeID)
);


CREATE TABLE Employee (
    EmployeeID INT NOT NULL UNIQUE,
    FirstName TEXT CHECK(length(FirstName) <= 40),
    LasttName TEXT CHECK(length(LastName) <= 40),
    BirthDay Date,
    Sex TEXT CHECK(length(Sex) <= 1),
    Salary INT,
    SuperID INT,
    BranchID INT,
    PRIMARY KEY(EmployeeID),
    FOREIGN KEY(SuperID) REFERENCES Branch(),
    FOREIGN KEY(BranchID) REFERENCES Branch(BranchID)
);


--Create table branch; branch_id is the primary key, Variable types are INT, VARCHAR(40), INT, DATE 
--As employee table already exists, we can define the foreign key (mgr_id) with reference to employee(emp_id)
--Add to table employee the super_id which is INT. It is the foreign key with reference to employee(emp_id)
--Add to table employee the branch_id which is INT. It is the foreign key with reference to branch(branch_id)
CREATE TABLE Branch (
    BranchID INT NOT NULL UNIQUE,
    BranchName TEXT CHECK(length(BranchName) <= 40),
    SuperID INT,
    MGR_StartDate DATE,
    PRIMARY KEY(BranchID),
    FOREIGN KEY(SuperID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

ALTER TABLE Employee
ADD SuperID INT
REFERENCES Employee(EmployeeID)
ON DELETE SET NULL;

ALTER TABLE Employee
ADD BranchID REFERENCES Branch(BranchID);

--Create table client; client_id is the primary key, Variable types are INT, VARCHAR(40), INT
--As branch table already exists, we can define the foreign key (branch_id) with reference to branch(branch_id)
CREATE TABLE Client (
    ClientID INT NOT NULL UNIQUE,
    ClientName TEXT CHECK(length(ClientName) <= 40),
    BranchID INT,
    PRIMARY KEY(ClientID),
    FOREIGN KEY(BranchID) REFERENCES Branch(BranchID)
);


--Create table works_with; the primary key is a composite of emp_id and client_id. Variable types are INT 
--As employee table already exists, we can define the foreign key (emp_id) with reference to employee(emp_id)
--As client table already exists, we can define the foreign key (client_id) with reference to client(client_id)
CREATE TABLE Works_With (
    EmployeeID INT NOT NULL UNIQUE,
    ClientName TEXT CHECK(length(ClientName) <= 40),
    TotalSales INT,
    PRIMARY KEY(EmployeeID, ClientID),
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY(ClientID) REFERENCES Client(ClientID)
);



--Create table branch_supplier; The primary key is a composite of branch_id and supplier_name.
---Variable types are INT, VARCHAR(40), VARCHAR(40).
--As branch table already exists, we can define the foreign key (branch_id) with reference to branch(branch_id)
CREATE TABLE Branch_Supplier (
    BranchID INT NOT NULL UNIQUE,
    SupplierName TEXT CHECK(length(SupplierName) <= 40),
    SupplyType TEXT CHECK(length(SupplyType) <= 40),
    PRIMARY KEY(BranchID),
    FOREIGN KEY(BranchID) REFERENCES Branch(BranchID)
);


-- See Session_8_practice_tables.xlsx for tables. Start with employees table, and David Wallace.
-- Attention, neither employees nor branch has entries, so you cannot set neither super_id nor brach_id see NULL




-- Insert the first branch Corporate
-- update the employee table with David’s branch
--Insert Jan
--Insert Michael, attention to non-existing branch 
-- Insert the first branch Scranton
-- Update Michael
--Insert Angela, Kelly, Stanley
-- Insert Josh, attention, his branch does not exist yet
-- Insert the necessary branch: Stamford
-- Update Josh
-- Insert Andy and Jim
-- Insert values to BRANCH SUPPLIER
-- Insert values to CLIENT
-- Insert values to WORKS_WITH