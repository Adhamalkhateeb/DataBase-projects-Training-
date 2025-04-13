
CREATE TABLE Persons (
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    PersonName NVARCHAR(100),
    ContactInfo NVARCHAR(MAX),
    Address NVARCHAR(255)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY IDENTITY(1,1),
    EmergencyContact NVARCHAR(100),
    BeltRankID INT FOREIGN KEY REFERENCES BeltRanks(RankID),
    IsActive BIT,
    PersonID INT FOREIGN KEY REFERENCES Persons(PersonID)
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY IDENTITY(1,1),
    Qualifications NVARCHAR(255),
    PersonID INT FOREIGN KEY REFERENCES Persons(PersonID)
);


CREATE TABLE BeltRanks (
    RankID INT PRIMARY KEY IDENTITY(1,1),
    RankName NVARCHAR(50),
    TestFees SMALLMONEY
);


CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY IDENTITY(1,1),
    StartDate DATE,
    EndDate DATE,
    Fees SMALLMONEY,
    IsActive BIT,
    MemberID INT FOREIGN KEY REFERENCES Members(MemberID),
    PaymentID INT FOREIGN KEY REFERENCES Payments(PaymentID)
);


CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    Amount DECIMAL(10,2),
    Date DATE,
    MemberID INT FOREIGN KEY REFERENCES Members(MemberID)
);

CREATE TABLE BeltTests (
    TestID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(MemberID),
    RankID INT FOREIGN KEY REFERENCES BeltRanks(RankID),
    Result BIT, -- 1 = Pass, 0 = Fail
    Date DATE,
    TestedInstructorID INT FOREIGN KEY REFERENCES Instructors(InstructorID),
    PaymentID INT FOREIGN KEY REFERENCES Payments(PaymentID)
);

CREATE TABLE MembersInstructors (
    InstructorID INT,
    MemberID INT,
    AssignDate DATE,
    PRIMARY KEY (InstructorID, MemberID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
