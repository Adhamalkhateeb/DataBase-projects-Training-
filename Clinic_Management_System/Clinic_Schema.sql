CREATE TABLE Person (
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Gender NVARCHAR(1),
    DateOfBirth DATE,
    Address NVARCHAR(200),
    PhoneNumber NVARCHAR(20),
    EmailAddress NVARCHAR(100)
);


CREATE TABLE Patient (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID)
);


CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    Specialization NVARCHAR(100),
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentDateTime DATETIME2,
    AppointmentStatus TINYINT, -- Use values 1-6 based on status list
    PatientID INT FOREIGN KEY REFERENCES Patient(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctor(DoctorID),
    PaymentID INT NULL,
    MedicalRecordID INT NULL
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    PaymentMethod NVARCHAR(50),
    AmountPaid DECIMAL(10,2),
    PaymentDate DATE,
    AdditionalNotes NVARCHAR(200)
);


CREATE TABLE MedicalRecord (
    MedicalRecordID INT PRIMARY KEY IDENTITY(1,1),
    Diagnosis NVARCHAR(200),
    VisitDescription NVARCHAR(200),
    AdditionalNotes NVARCHAR(200)
);


CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
    Dosage NVARCHAR(50),
    Frequency NVARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    MedicationName NVARCHAR(100),
    SpecialInstruction NVARCHAR(200),
    MedicalRecordID INT FOREIGN KEY REFERENCES MedicalRecord(MedicalRecordID)
);
