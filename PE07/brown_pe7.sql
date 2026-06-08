-- AUTHOR: Jeliel Brown
-- DATE: 11/12/2025
-- ISTE-230 PE7 Schema

DROP DATABASE IF EXISTS brown_pe7;
CREATE DATABASE brown_pe7;
USE brown_pe7;

CREATE TABLE Person (
    person_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    person_type ENUM('STAFF', 'PATIENT', 'BOTH', 'NONE') DEFAULT 'NONE',
    CONSTRAINT person_pk PRIMARY KEY (person_id)
);

CREATE TABLE Patient (
    patient_id SMALLINT UNSIGNED NOT NULL,
    doctor_id SMALLINT UNSIGNED,
    CONSTRAINT patient_pk PRIMARY KEY (patient_id),
    CONSTRAINT patient_person_id_fk FOREIGN KEY (patient_id) REFERENCES Person(person_id),
    CONSTRAINT patient_doctor_id_fk FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Staff (
    staff_id SMALLINT UNSIGNED NOT NULL,
    manager_id SMALLINT UNSIGNED,
    CONSTRAINT staff_id PRIMARY KEY (staff_id),
    CONSTRAINT person_staff_id_fk FOREIGN KEY (staff_id) REFERENCES Person(person_id),
    CONSTRAINT staff_manager_id_fk FOREIGN KEY (manager_id) REFERENCES Staff(staff_id)
);

CREATE TABLE SupportStaff (
    support_staff_id SMALLINT UNSIGNED NOT NULL,
    wage DECIMAL(5,2) NOT NULL,
    CONSTRAINT support_staff_pk PRIMARY KEY (support_staff_id),
    CONSTRAINT support_staff_staff_id_fk FOREIGN KEY (support_staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Doctor (
    doctor_id SMALLINT UNSIGNED NOT NULL,
    mentor_id SMALLINT UNSIGNED,
    CONSTRAINT doctor_pk PRIMARY KEY (doctor_id),
    CONSTRAINT staff_doctor_id_fk FOREIGN KEY (doctor_id) REFERENCES Staff(staff_id),
    CONSTRAINT doctor_mentor_id_fk FOREIGN KEY (mentor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Nurse (
    nurse_id SMALLINT UNSIGNED NOT NULL,
    certification ENUM('LPN','RN','APRN') NOT NULL,
    CONSTRAINT nurse_pk PRIMARY KEY (nurse_id),
    CONSTRAINT nurse_staff_id_fk FOREIGN KEY (nurse_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Department (
    dept_num TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT department_pk PRIMARY KEY (dept_num)
);

CREATE TABLE DepartmentStaff (
    dept_num TINYINT UNSIGNED NOT NULL,
    staff_id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT department_staff_pk PRIMARY KEY (dept_num, staff_id),
    CONSTRAINT department_staff_dept_num_fk FOREIGN KEY (dept_num) REFERENCES Department(dept_num),
    CONSTRAINT department_staff_staff_id_fk FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE InsuranceCompany (
    co_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    CONSTRAINT insurance_company_pk PRIMARY KEY (co_id)
);

CREATE TABLE InsurancePolicy (
    policy_num VARCHAR(25) NOT NULL,
    patient_id SMALLINT UNSIGNED NOT NULL,
    ins_co_id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT insurance_policy_pk PRIMARY KEY (policy_num),
    CONSTRAINT insurance_policy_patient_id_fk FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    CONSTRAINT insurance_policy_ins_co_id_fk FOREIGN KEY (ins_co_id) REFERENCES InsuranceCompany(co_id)
);

