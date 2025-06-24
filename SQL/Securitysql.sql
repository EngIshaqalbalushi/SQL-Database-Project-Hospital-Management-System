

-- Security (DCL)
--Create at least two user roles: DoctorUser, AdminUser.

-- Create roles
CREATE ROLE DoctorUser;
CREATE ROLE AdminUser;



-- GRANT SELECT for DoctorUser on Patients and Appointments only.

-- Grant SELECT permission only on Patients and Appointments
GRANT SELECT ON Patients TO DoctorUser;
GRANT SELECT ON Appointments TO DoctorUser;


--GRANT INSERT, UPDATE for AdminUser on all tables.
-- Grant INSERT and UPDATE on all relevant tables
GRANT INSERT, UPDATE ON Patients TO AdminUser;
GRANT INSERT, UPDATE ON Doctors TO AdminUser;
GRANT INSERT, UPDATE ON Appointments TO AdminUser;
GRANT INSERT, UPDATE ON Departments TO AdminUser;
GRANT INSERT, UPDATE ON Admissions TO AdminUser;
GRANT INSERT, UPDATE ON Rooms TO AdminUser;
GRANT INSERT, UPDATE ON MedicalRecords TO AdminUser;
GRANT INSERT, UPDATE ON Billing TO AdminUser;
GRANT INSERT, UPDATE ON Staff TO AdminUser;
GRANT INSERT, UPDATE ON Users TO AdminUser;



--REVOKE DELETE for Doctors


REVOKE DELETE ON Doctors FROM PUBLIC;
