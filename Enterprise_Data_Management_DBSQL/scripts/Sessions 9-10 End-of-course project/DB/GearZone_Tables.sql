---Create Table Customer---
CREATE TABLE Customer (
    CustomerID TEXT NOT NULL UNIQUE,
    CustomerName TEXT,
    CustomerZipCode TEXT CHECK(length(CustomerZipCode) = 5) DEFAULT 11111,
    PRIMARY KEY(CustomerID)
);

---Create Table Region---
CREATE TABLE Region (
    RegionID TEXT NOT NULL UNIQUE,
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
    VendorID TEXT NOT NULL UNIQUE,
    VendorName TEXT,
    PRIMARY KEY(VendorID)
);

---Create Table Category---
CREATE TABLE Category (
    CategoryID TEXT NOT NULL UNIQUE,
    CategoryName TEXT,
    PRIMARY KEY(CategoryID)
);

---Create Table SalesTransaction---
CREATE TABLE SalesTransaction (
    SalesID TEXT NOT NULL UNIQUE,
    CustomerID TEXT,
    StoreID TEXT,
    SalesDate DATE,
    PRIMARY KEY(SalesID),
    FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY(StoreID) REFERENCES Store(StoreID) ON DELETE CASCADE
);

---Create Table Product---
CREATE TABLE Product (
    ProductID TEXT NOT NULL UNIQUE,
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

DROP TABLE IF EXISTS Store;







