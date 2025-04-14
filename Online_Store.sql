
CREATE DATABASE OnlineStore;


USE OnlineStore;

CREATE TABLE ProductCategories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    ParentCategoryID INT NULL,
    FOREIGN KEY (ParentCategoryID) REFERENCES ProductCategories(CategoryID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2) NOT NULL,
    QuantityInStock INT NOT NULL DEFAULT 0,
    CategoryID INT,
    DateAdded DATETIME NOT NULL DEFAULT GETDATE(),
    LastUpdated DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (CategoryID) REFERENCES ProductCategories(CategoryID)
);


CREATE TABLE ProductImages (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    ImageURL NVARCHAR(500) NOT NULL,
    IsPrimary BIT DEFAULT 0,
    DisplayOrder INT DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Phone NVARCHAR(20),
    PasswordHash NVARCHAR(255) NOT NULL,
    Salt NVARCHAR(100) NOT NULL,
    DateRegistered DATETIME NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME,
    IsActive BIT DEFAULT 1
);


CREATE TABLE CustomerAddresses (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    AddressType NVARCHAR(20) NOT NULL, -- 'Shipping' or 'Billing'
    StreetAddress NVARCHAR(200) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    State NVARCHAR(100) NOT NULL,
    PostalCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
    IsDefault BIT DEFAULT 0,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderStatus (
    StatusID INT PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);


CREATE TABLE ShippingMethods (
    MethodID INT PRIMARY KEY IDENTITY(1,1),
    MethodName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(200),
    Cost DECIMAL(10, 2) NOT NULL,
    EstimatedDeliveryDays INT
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderNumber NVARCHAR(20) NOT NULL UNIQUE,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    StatusID INT NOT NULL DEFAULT 1,
    ShippingMethodID INT,
    ShippingAddressID INT,
    BillingAddressID INT,
    Notes NVARCHAR(MAX),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StatusID) REFERENCES OrderStatus(StatusID),
    FOREIGN KEY (ShippingMethodID) REFERENCES ShippingMethods(MethodID),
    FOREIGN KEY (ShippingAddressID) REFERENCES CustomerAddresses(AddressID),
    FOREIGN KEY (BillingAddressID) REFERENCES CustomerAddresses(AddressID)
);


CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Discount DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE ShippingStatus (
    ShippingStatusID INT PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);


CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    CarrierName NVARCHAR(100) NOT NULL,
    TrackingNumber NVARCHAR(100),
    ShippingStatusID INT NOT NULL DEFAULT 1,
    EstimatedDeliveryDate DATE,
    ActualDeliveryDate DATE,
    ShippingCost DECIMAL(10, 2) NOT NULL,
    Notes NVARCHAR(MAX),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ShippingStatusID) REFERENCES ShippingStatus(ShippingStatusID)
);


CREATE TABLE PaymentMethods (
    MethodID INT PRIMARY KEY IDENTITY(1,1),
    MethodName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);


CREATE TABLE PaymentTransactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL, -- 'Pending', 'Completed', 'Failed', 'Refunded'
    GatewayResponse NVARCHAR(MAX),
    TransactionReference NVARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(MethodID)
);


CREATE TABLE ProductReviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    Rating TINYINT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewText NVARCHAR(MAX),
    ReviewDate DATETIME NOT NULL DEFAULT GETDATE(),
    IsApproved BIT DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TYPE OrderItemType AS TABLE (
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Discount DECIMAL(10, 2)
);


