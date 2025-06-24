

--Triggers

-- After insert on Appointments → auto log in MedicalRecords.
CREATE TRIGGER trg_AfterInsert_AppointmentLog
ON Appointments
AFTER INSERT
AS
BEGIN
    INSERT INTO MedicalRecords (PatientID, DoctorID, Diagnosis, TreatmentPlan, RecordDate, Notes)
    SELECT 
        i.PatientID,
        i.DoctorID,
        'Pending Diagnosis',        -- default value
        'To be determined',         -- default value
        GETDATE(),
        'Auto-created record from appointment.'
    FROM INSERTED i;
END;


-- Before delete on Patients → prevent deletion if pending bills exist.
CREATE TRIGGER trg_PreventPatientDeleteIfBills
ON Patients
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Billing b
        JOIN DELETED d ON b.PatientID = d.PatientID
    )
    BEGIN
        RAISERROR('Cannot delete patient with existing billing records.', 16, 1);
        ROLLBACK;
    END
    ELSE
    BEGIN
        DELETE FROM Patients
        WHERE PatientID IN (SELECT PatientID FROM DELETED);
    END
END;


-- After update on Rooms → ensure no two patients occupy same room.CREATE TRIGGER trg_NoRoomOverlap
ON Admissions
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Admissions a1
        JOIN Admissions a2 ON 
            a1.RoomID = a2.RoomID AND
            a1.AdmissionID <> a2.AdmissionID AND
            a1.DateIn <= a2.DateOut AND
            a1.DateOut >= a2.DateIn
    )
    BEGIN
        RAISERROR('Conflict: Multiple patients assigned to the same room at the same time.', 16, 1);
        ROLLBACK;
    END
END;
