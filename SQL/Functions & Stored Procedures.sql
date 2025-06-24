

--Scalar function to calculate patient age from DOB.
CREATE FUNCTION dbo.fn_CalculatePatientAge (@DOB DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DOB, GETDATE()) 
         - CASE 
               WHEN MONTH(@DOB) > MONTH(GETDATE()) 
                    OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
               THEN 1 
               ELSE 0 
           END;
END;


--Stored procedure to admit a patient (insert to Admissions, update Room availability).
CREATE PROCEDURE dbo.sp_AdmitPatient
    @PatientID INT,
    @RoomID INT,
    @DateIn DATE,
    @DateOut DATE
AS
BEGIN
    -- Insert admission record
    INSERT INTO Admissions (PatientID, RoomID, DateIn, DateOut)
    VALUES (@PatientID, @RoomID, @DateIn, @DateOut);

    -- Update room availability
    UPDATE Rooms
    SET IsAvailable = 0
    WHERE RoomID = @RoomID;
END;


--Procedure to generate invoice (insert into Billing based on treatments).
CREATE PROCEDURE dbo.sp_GenerateInvoice
    @PatientID INT,
    @Services NVARCHAR(200),
    @TotalCost DECIMAL(10,2),
    @BillingDate DATE
AS
BEGIN
    INSERT INTO Billing (PatientID, Services, TotalCost, BillingDate)
    VALUES (@PatientID, @Services, @TotalCost, @BillingDate);
END;


--Procedure to assign doctor to department and shift
CREATE PROCEDURE dbo.sp_AssignDoctorToDepartment
    @DoctorID INT,
    @DepartmentID INT
AS
BEGIN
    UPDATE Doctors
    SET DepartmentID = @DepartmentID
    WHERE DoctorID = @DoctorID;
END;
