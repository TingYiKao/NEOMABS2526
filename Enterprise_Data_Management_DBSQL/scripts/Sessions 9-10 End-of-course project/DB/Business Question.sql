---Chen HE, WenTing Xu, and TingYi KAO---
---Create Table Customer---
CREATE TABLE Customer (
    CustomerID TEXT NOT NULL,
    CustomerName TEXT,
    CustomerZipCode TEXT CHECK(length(CustomerZipCode) = 5) DEFAULT 11111,
    PRIMARY KEY(CustomerID)
);

---Create Table Region---
CREATE TABLE Region (
    RegionID TEXT NOT NULL,
    RegionName TEXT,
    PRIMARY KEY(RegionID)
);

---Create Table Store---
CREATE TABLE Store (
    StoreID TEXT PRIMARY KEY,
    StoreZipCode TEXT CHECK(length(StoreZipCode) = 5) DEFAULT '11111',
    RegionID TEXT NOT NULL,
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID) ON DELETE CASCADE
);

---Create Table Vendor---
CREATE TABLE Vendor (
    VendorID TEXT NOT NULL,
    VendorName TEXT,
    PRIMARY KEY(VendorID)
);

---Create Table Category---
CREATE TABLE Category (
    CategoryID TEXT NOT NULL,
    CategoryName TEXT,
    PRIMARY KEY(CategoryID)
);

---Create Table SalesTransaction---
CREATE TABLE SalesTransaction (
    SalesID TEXT NOT NULL,
    CustomerID TEXT,
    StoreID TEXT,
    SalesDate DATE,
    PRIMARY KEY(SalesID),
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY(StoreID) REFERENCES Store(StoreID) ON DELETE CASCADE
);

---Create Table Product---
CREATE TABLE Product (
    ProductID TEXT NOT NULL,
    ProductName TEXT,
    ProductUnitPrice INT,
    VendorID TEXT,
    CategoryID TEXT,
    PRIMARY KEY(ProductID),
    FOREIGN KEY(VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE,
    FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
);

---Create Table SalesDetails---
CREATE TABLE SalesDetails (
    SalesID TEXT NOT NULL,
    ProductID TEXT NOT NULL,
    ProductQuantity INT,
    PRIMARY KEY(SalesID, ProductID),
    FOREIGN KEY(SalesID) REFERENCES SalesTransaction(SalesID) ON DELETE CASCADE,
    FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);

---Insert Region Data---
INSERT INTO Region (RegionID, RegionName) VALUES
  ('MR', 'Mountain Region'),
  ('CR', 'Coastal Region'),
  ('PR', 'Plains Region'),
  ('DR', 'Desert Region'),
  ('FR', 'Forest Region'),
  ('UR', 'Urban Region'),
  ('SR', 'Suburban Region'),
  ('HR', 'Highlands Region'),
  ('LR', 'Lakeside Region'),
  ('RR', 'River Region'),
  ('IR', 'Island Region'),
  ('AR', 'Arctic Region'),
  ('TR', 'Tropical Region'),
  ('VR', 'Valley Region'),
  ('BR', 'Border Region');
  
---Insert Vendor Data---
INSERT INTO Vendor (VendorID, VendorName) VALUES
  ('GS', 'Gear Supplies Co.'),
  ('TM', 'Trail Master Equipment'),
  ('OE', 'Outdoor Essentials Ltd.'),
  ('HN', 'Highland Naturals'),
  ('RC', 'River & Camp Co.'),
  ('UR', 'Urban Rec Gear'),
  ('SW', 'Summit Works'),
  ('BF', 'Backcountry Friends'),
  ('LW', 'Lakeside Wear'),
  ('FS', 'Forest & Stream'),
  ('TR', 'Trailridge Outfitters'),
  ('AP', 'Alpine Provisions'),
  ('DS', 'Desert Sun Outfitters'),
  ('IS', 'Island Sports Co.'),
  ('VG', 'Valley Gear Traders');

---Insert Category Data---
INSERT INTO Category (CategoryID, CategoryName) VALUES
  ('CG', 'Camping Gear'),
  ('FW', 'Footwear'),
  ('CL', 'Clothing'),
  ('BK', 'Backpacks'),
  ('CO', 'Cooking'),
  ('LT', 'Lighting'),
  ('SN', 'Snowsports'),
  ('CY', 'Cycling'),
  ('CLM', 'Climbing'),
  ('NV', 'Navigation'),
  ('WS', 'Water Sports'),
  ('FA', 'First Aid'),
  ('TRV', 'Travel Accessories'),
  ('EL', 'Electronics'),
  ('MF', 'Mountain Fitness');

---Insert Customer Data---
INSERT INTO Customer (CustomerID, CustomerName, CustomerZipCode) VALUES
  ('1-1-111', 'Alex', '80202'),
  ('2-2-222', 'Jordan', '94105'),
  ('3-3-333', 'Taylor', '30303'),
  ('4-4-444', 'Morgan', '84101'),
  ('5-5-555', 'Riley', '73301'),
  ('6-6-666', 'Casey', '15222'),
  ('7-7-777', 'Jamie', '10001'),
  ('8-8-888', 'Avery', '07030'),
  ('9-9-999', 'Quinn', '80216'),
  ('10-10-10', 'Reese', '53140'),
  ('11-11-11', 'Hayden', '70112'),
  ('12-12-12', 'Skyler', '96815'),
  ('13-13-13', 'Parker', '99501'),
  ('14-14-14', 'Dakota', '33139'),
  ('15-15-15', 'Emerson', '84532');
  
---Insert Store Data---
INSERT INTO Store (StoreID, StoreZipCode, RegionID) VALUES
  ('S1', '80202', 'MR'),
  ('S2', '94105', 'MR'),
  ('S3', '30303', 'CR'),
  ('S4', '84101', 'PR'),
  ('S5', '73301', 'DR'),
  ('S6', '15222', 'FR'),
  ('S7', '10001', 'UR'),
  ('S8', '07030', 'SR'),
  ('S9', '80216', 'HR'),
  ('S10', '53140', 'LR'),
  ('S11', '70112', 'RR'),
  ('S12', '96815', 'IR'),
  ('S13', '99501', 'AR'),
  ('S14', '33139', 'TR'),
  ('S15', '84532', 'VR');
  
---Insert SalesTransaction Data---
INSERT INTO SalesTransaction (SalesID, CustomerID, StoreID, SalesDate) VALUES
  ('T101', '1-1-111', 'S1', '2022-01-01'),
  ('T202', '2-2-222', 'S2', '2022-01-01'),
  ('T303', '1-1-111', 'S3', '2022-01-02'),
  ('T404', '3-3-333', 'S3', '2022-01-02'),
  ('T505', '2-2-222', 'S3', '2022-01-02'),
  ('T606', '3-3-333', 'S2', '2022-01-03'),
  ('T707', '4-4-444', 'S4', '2022-01-03'),
  ('T808', '5-5-555', 'S5', '2022-01-04'),
  ('T909', '6-6-666', 'S6', '2022-01-04'),
  ('T010', '7-7-777', 'S7', '2022-01-05'),
  ('T111', '8-8-888', 'S8', '2022-01-05'),
  ('T121', '9-9-999', 'S9', '2022-01-06'),
  ('T131', '10-10-10', 'S10', '2022-01-06'),
  ('T141', '11-11-11', 'S11', '2022-01-07'),
  ('T151', '12-12-12', 'S12', '2022-01-07');

---Insert Product Data---
INSERT INTO Product (ProductID, ProductName, ProductUnitPrice, VendorID, CategoryID) VALUES
  ('1A1', 'Trail Backpack', 120, 'GS', 'CG'),
  ('2B2', 'Hiking Boots', 85, 'TM', 'FW'),
  ('3C3', 'Cozy Socks', 20, 'TM', 'FW'),
  ('4D4', 'Rainproof Jacket', 95, 'GS', 'FW'),
  ('5E5', 'Compact Tent', 180, 'TM', 'CG'),
  ('6F6', 'Explorer Tent', 300, 'TM', 'CG'),
  ('7G7', 'Camp Stove', 60, 'OE', 'CO'),
  ('8H8', 'Lantern Pro', 45, 'OE', 'LT'),
  ('9I9', 'Thermal Jacket', 150, 'HN', 'CL'),
  ('1J1', 'Snow Goggles', 70, 'SW', 'SN'),
  ('2K2', 'Climbing Harness', 110, 'SW', 'CLM'),
  ('3L3', 'GPS Navigator', 200, 'TR', 'NV'),
  ('4M4', 'Dry Bag 20L', 35, 'BF', 'WS'),
  ('5N5', 'First Aid Kit', 40, 'UR', 'FA'),
  ('6P6', 'Travel Pillow', 25, 'VG', 'TRV');
  
---Insert SalesDetails Data---
INSERT INTO SalesDetails (ProductID, SalesID, ProductQuantity) VALUES
  ('1A1', 'T101', 1),
  ('2B2', 'T202', 1),
  ('3C3', 'T303', 3),
  ('1A1', 'T303', 1),
  ('4D4', 'T404', 2),
  ('2B2', 'T404', 1),
  ('4D4', 'T505', 4),
  ('5E5', 'T505', 2),
  ('6F6', 'T505', 1),
  ('7G7', 'T606', 2),
  ('3C3', 'T606', 1),
  ('8H8', 'T707', 1),
  ('9I9', 'T808', 2),
  ('1J1', 'T909', 1),
  ('5N5', 'T151', 3);


  
---Test---
SELECT RegionID, RegionName
FROM Region;
  

--Displays sales revenues for each store in each region, sorted by revenues from highest to lowest.
SELECT a.RegionID, b.StoreID, SUM(c.ProductQuantity*d.ProductUnitPrice) As Sales_Revenue
FROM Store a JOIN SalesTransaction b ON a.StoreID=b.StoreID
JOIN SalesDetails c ON b.SalesID =c.SalesID
JOIN Product d ON c.ProductID=d.ProductID
GROUP BY a.RegionID, b.StoreID
ORDER BY Sales_Revenue DESC;


---Find the Customer Who Purchased the Most---
SELECT c.CustomerName, c.CustomerID, SUM(p.ProductUnitPrice*sd.ProductQuantity) AS Total_Purchase
FROM Customer c
JOIN SalesTransaction st ON c.CustomerID = st.CustomerID
JOIN SalesDetails sd ON st.SalesID = sd.SalesID
JOIN Product p  ON p.ProductID = sd.ProductID
GROUP BY c.CustomerID,c.CustomerName
ORDER BY Total_Purchase DESC;
