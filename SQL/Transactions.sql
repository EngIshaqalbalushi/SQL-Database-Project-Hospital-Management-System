

--Transactions (TCL)

--Simulate a transaction: admit a patient → insert record, update room, create billing → commit.
BEGIN TRY
    BEGIN TRANSACTION;

    -- Step 1: Insert into Admissions
    INSERT INTO Admissions (PatientID, RoomID, DateIn, DateOut)
    VALUES (105, 12, '2025-06-23', '2025-06-27');

    -- Step 2: Update Room Availability
    UPDATE Rooms
    SET IsAvailable = 0
    WHERE RoomID = 12;

    -- Step 3: Insert into Billing
    INSERT INTO Billing (PatientID, TotalCost, Services, BillingDate)
    VALUES (105, 600.00, 'Room Charge, Admission', GETDATE());

    -- If all successful
    COMMIT TRANSACTION;
    PRINT ' Transaction committed: patient admitted and billed.';
END TRY
BEGIN CATCH
    -- On any error, rollback
    ROLLBACK TRANSACTION;
    PRINT ' Transaction failed: ' + ERROR_MESSAGE();
END CATCH;


-- Add rollback logic in case of failure.

BEGIN TRY
    BEGIN TRANSACTION;

    -- Step 1: Admit the patient
    INSERT INTO Admissions (PatientID, RoomID, DateIn, DateOut)
    VALUES (105, 12, '2025-06-23', '2025-06-27');

    -- Step 2: Update room availability
    UPDATE Rooms
    SET IsAvailable = 0
    WHERE RoomID = 12;

    -- Step 3: Create billing record
    INSERT INTO Billing (PatientID, TotalCost, Services, BillingDate)
    VALUES (105, 600.00, 'Admission, Room Charges', GETDATE());

    -- ✅ Commit if all succeeds
    COMMIT TRANSACTION;
    PRINT ' Transaction committed successfully.';
END TRY
BEGIN CATCH
    -- ❌ Rollback if any step fails
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    -- Display the error message
    PRINT ' Transaction failed. Rolled back due to error: ' + ERROR_MESSAGE();
END CATCH;
