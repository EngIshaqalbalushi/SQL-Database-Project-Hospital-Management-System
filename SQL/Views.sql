
 --Views
-- vw_DoctorSchedule: Upcoming appointments per doctor.
CREATE VIEW vw_DoctorSchedule AS
SELECT 
    d.DoctorID,
    d.Name AS DoctorName,
    d.Specialization,
    a.AppointmentID,
    p.Name AS PatientName,
    a.AppointmentTime
FROM Appointments a
JOIN Doctors d ON a.DoctorID = d.DoctorID
JOIN Patients p ON a.PatientID = p.PatientID
WHERE a.AppointmentTime >= GETDATE()
ORDER BY d.DoctorID, a.AppointmentTime;


-- vw_PatientSummary: Patient info with their latest visit.

CREATE VIEW vw_PatientSummary AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    p.DOB,
    p.Gender,
    p.ContactInfo,
    MAX(a.AppointmentTime) AS LastVisit
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.Name, p.DOB, p.Gender, p.ContactInfo;


-- vw_DepartmentStats: Number of doctors and patients per department.

CREATE VIEW vw_DepartmentStats AS
SELECT 
    dep.DepartmentID,
    dep.DepartmentName,
    COUNT(DISTINCT d.DoctorID) AS TotalDoctors,
    COUNT(DISTINCT a.PatientID) AS TotalPatients
FROM Departments dep
LEFT JOIN Doctors d ON dep.DepartmentID = d.DepartmentID
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY dep.DepartmentID, dep.DepartmentName;
