
CREATE DATABASE CarRentalSystem;


USE CarRentalSystem;

CREATE TABLE FuelTypes (
    TypeID INT PRIMARY KEY IDENTITY(1,1),
    FuelType NVARCHAR(20) NOT NULL
);

CREATE TABLE VehicleCategory (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    DriverLicenseNumber NVARCHAR(20) NOT NULL,
    ContactInformation NVARCHAR(100) NOT NULL
);


CREATE TABLE Vehicles (
    VehicleID INT PRIMARY KEY IDENTITY(1,1),
    Model NVARCHAR(50) NOT NULL,
    Make NVARCHAR(50) NOT NULL,
    Mileage INT NOT NULL,
    PlateNumber NVARCHAR(20) NOT NULL UNIQUE,
    [Year] INT NOT NULL,
    RentalPricePerDay DECIMAL(10, 2) NOT NULL,
    IsAvailable BIT DEFAULT 1,
    FuelTypeID INT NOT NULL,
    CarCategoryID INT NOT NULL,
    FOREIGN KEY (FuelTypeID) REFERENCES FuelTypes(TypeID),
    FOREIGN KEY (CarCategoryID) REFERENCES VehicleCategory(CategoryID)
);


CREATE TABLE RentalBooking (
    RentalID INT PRIMARY KEY IDENTITY(1,1),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    PickUpLocation NVARCHAR(100) NOT NULL,
    DropOffLocation NVARCHAR(100) NOT NULL,
    InitialTotalDueAmount SMALLMONEY NOT NULL,
    InitialVehicleCheckNotes NVARCHAR(MAX),
    InitialRentalDays TINYINT NOT NULL,
    InitialPricePerDay SMALLMONEY NOT NULL,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);


CREATE TABLE ReturnedVehicles (
    ReturnID INT PRIMARY KEY IDENTITY(1,1),
    ActualReturnDate DATETIME NOT NULL,
    ActualRentalDays TINYINT NOT NULL,
    FinalVehicleCheckNotes NVARCHAR(MAX),
    AdditionalCharge SMALLMONEY DEFAULT 0,
    Mileage SMALLINT NOT NULL,
    ConsumedMileage SMALLINT NOT NULL,
    ActualTotalDueAmount SMALLMONEY NOT NULL,
    RentID INT NOT NULL,
    FOREIGN KEY (RentID) REFERENCES RentalBooking(RentalID)
);


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    PaymentDetails NVARCHAR(100) NOT NULL,
    PaidInitialTotalDueAmount SMALLMONEY NOT NULL,
    ActualTotalDueAmount SMALLMONEY,
    TotalRemaining SMALLMONEY,
    TotalRefundedAmount SMALLMONEY,
    TransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedTransactionDate DATETIME,
    ReturnID INT,
    RentalID INT NOT NULL,
    FOREIGN KEY (ReturnID) REFERENCES ReturnedVehicles(ReturnID),
    FOREIGN KEY (RentalID) REFERENCES RentalBooking(RentalID)
);


CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    VehicleID INT NOT NULL,
    Description NVARCHAR(300) NOT NULL,
    MaintenanceDate DATE NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);






    
 
