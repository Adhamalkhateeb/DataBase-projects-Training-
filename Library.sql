
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    BookTitle NVARCHAR(255),
    Author NVARCHAR(100),
    PublicationDate DATE,
    ISBN NVARCHAR(50),
    Genre NVARCHAR(50),
    AdditionalNotes NVARCHAR(MAX)
);

CREATE TABLE BookCopies (
    CopyID INT PRIMARY KEY IDENTITY(1,1),
    BookID INT FOREIGN KEY REFERENCES Books(BookID),
    AvailabilityStatus BIT -- 1 = Available, 0 = Checked Out
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100),
    ContactInformation NVARCHAR(255),
    LibraryCardNumber NVARCHAR(50)
);

CREATE TABLE BorrowingRecords (
    BorrowRecordID INT PRIMARY KEY IDENTITY(1,1),
    BorrowingDate DATE,
    DueDate DATE,
    ActualReturnDate DATE NULL,
    CopyID INT FOREIGN KEY REFERENCES BookCopies(CopyID),
    UserID INT FOREIGN KEY REFERENCES Users(UserID)
);

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    ReservationDate DATE,
    CopyID INT FOREIGN KEY REFERENCES BookCopies(CopyID),
    UserID INT FOREIGN KEY REFERENCES Users(UserID)
);

CREATE TABLE Fines (
    FineID INT PRIMARY KEY IDENTITY(1,1),
    NumberOfLateDays SMALLINT,
    FineAmount DECIMAL(10,2),
    FineStatus BIT, -- 1 = Paid, 0 = Unpaid
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    BorrowRecordID INT FOREIGN KEY REFERENCES BorrowingRecords(BorrowRecordID)
);


CREATE TABLE Settings (
    SettingID INT PRIMARY KEY IDENTITY(1,1),
    DefaultBorrowDays TINYINT,
    DefaultFinePerDay DECIMAL(5,2)
);
