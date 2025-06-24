
--List all patients who visited a certain doctor.

SELECT DISTINCT p.PatientID, p.Name AS PatientName
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
WHERE a.DoctorID = 5;

--Count of appointments per department.
SELECT d.DepartmentName, COUNT(a.AppointmentID) AS AppointmentCount
FROM Appointments a
JOIN Doctors doc ON a.DoctorID = doc.DoctorID
JOIN Departments d ON doc.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


-- Retrieve doctors who have more than 5 appointments in a month.
SELECT d.DoctorID, d.Name, COUNT(a.AppointmentID) AS TotalAppointments
FROM Appointments a
JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE MONTH(a.AppointmentTime) = MONTH(GETDATE())  -- current month
GROUP BY d.DoctorID, d.Name
HAVING COUNT(a.AppointmentID) > 5;

--Use JOINs across 3–4 tables.
SELECT 
    a.AppointmentID,
    p.Name AS PatientName,
    d.Name AS DoctorName,
    dep.DepartmentName,
    a.AppointmentTime
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
JOIN Departments dep ON d.DepartmentID = dep.DepartmentID;

-- Use GROUP BY, HAVING, and aggregate functions.
SELECT b.PatientID, p.Name AS PatientName, SUM(b.TotalCost) AS TotalSpent
FROM Billing b
JOIN Patients p ON b.PatientID = p.PatientID
GROUP BY b.PatientID, p.Name
HAVING SUM(b.TotalCost) > 1000;



-- Use SUBQUERIES and EXISTS

SELECT p.PatientID, p.Name
FROM Patients p
WHERE p.PatientID IN (
    SELECT a.PatientID
    FROM Appointments a
    JOIN Doctors d ON a.DoctorID = d.DoctorID
    JOIN Departments dep ON d.DepartmentID = dep.DepartmentID
    WHERE dep.DepartmentName = 'Cardiology'
);
