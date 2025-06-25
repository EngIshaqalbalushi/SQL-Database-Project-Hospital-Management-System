
# 🏥 Hospital Management System – SQL Server Project

This project presents a full-featured **Hospital Management System** built using **Microsoft SQL Server**. It simulates core hospital operations such as patient management, doctor assignment, appointment scheduling, billing, and medical records tracking with real-world logic using SQL techniques like **joins**, **constraints**, **triggers**, **procedures**, **functions**, and **DCL permissions**.

---

## 📌 Project Overview

- 📊 Designed using normalized relational schema
- 🧠 Implements business rules via **triggers** and **stored procedures**
- 🔐 Enforces access control with **roles and permissions**
- 🧪 Comes with 20+ realistic records per table (Omani names used)
- 🗃 Includes ERD, table mappings, data population, and test queries

---

## 📁 Project Contents

```bash
📦 Hospital-Management-System/
├── README.md                    # Project documentation
├── HospitalSystem.sql           # Table creation scripts with constraints
├── SampleData.sql               # Insert statements with 20+ records per table
├── StoredProcedures.sql         # Functions and procedures
├── Triggers.sql                 # Triggers implementing business rules
├── SecurityRoles.sql            # DCL: role-based permissions
├── ERD.png                      # Entity-Relationship Diagram
├── MappingDiagram.png           # Relational schema mapping
```

---

## 🔍 Key Database Tables

| Table          | Description |
|----------------|-------------|
| Patients       | Patient demographic & contact info |
| Doctors        | Doctor personal info & specialization |
| Departments    | Hospital departments (e.g., Cardiology) |
| Appointments   | Doctor-patient meetings with datetime |
| Admissions     | Tracks room occupancy for patients |
| Rooms          | Room type and availability |
| Billing        | Cost breakdown and services billed |
| MedicalRecords | Diagnosis, treatment, and visit logs |
| Users          | System logins with role distinction |
| Staff          | Non-doctor hospital employees |

---

## 📦 Features

### ✅ Table Design
- Primary and Foreign Keys
- Identity fields (where applicable)
- Data integrity with CHECK constraints and DEFAULTs

### ✅ Triggers
| Trigger Name                            | Description |
|----------------------------------------|-------------|
| `trg_AfterInsert_Appointment_MedicalLog` | Auto-log new appointment in `MedicalRecords` |
| `trg_PreventPatientDelete_IfBillsExist` | Prevent deleting patient if bills exist |
| `trg_ValidateRoomAssignment`            | Prevent multiple patients in same room/time |

### ✅ Stored Procedures
- `sp_AdmitPatient`: Admit and assign room
- `sp_GenerateInvoice`: Generate bill from treatments
- `sp_AssignDoctorToDept`: Assign doctor to department

### ✅ Scalar Function
- `fn_CalculateAgeFromDOB`: Get age from date of birth

### ✅ Security & Roles (DCL)
- `DoctorUser`: SELECT access on `Patients`, `Appointments`
- `AdminUser`: Full INSERT, UPDATE privileges
- REVOKE DELETE from `Doctors` for all roles

---

## 🔍 Example Queries

- List patients seen by a specific doctor
- Count appointments per department
- List doctors with >5 appointments in a month
- Subqueries using `EXISTS` and aggregations with `HAVING`

---

## 🛠 Setup Instructions

1. Run `HospitalSystem.sql` to create schema
2. Execute `SampleData.sql` to populate data
3. Add procedures, triggers, and functions using corresponding `.sql` files
4. Run `SecurityRoles.sql` to enforce role-based access
5. Use `SSMS` or `Azure Data Studio` to explore data

---

## 🖼️ Diagrams

### Entity-Relationship Diagram (ERD)
Included in `ERD.png` – shows key entities and relationships

### Mapping Diagram
See `MappingDiagram.png` for table and attribute mapping

---

## 👨‍💻 Author

**Your Name**  
GitHub: [@your-username](https://github.com/your-username)  
Email: your@email.com

---

## 📄 License

This project is open-source and available for learning and development use.
