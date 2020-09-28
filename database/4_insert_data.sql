-- Inserts sample data.

-- insert users data
INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('hengd', 'S4736343H', 'patient', 'Ding Heng', 'Lim', '13/11/1992', 'male', '85556669', '20 Heng Mui Keng Terrace');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('sean', 'S6173429E', 'patient', 'Sean', 'Yap', '20/08/1994', 'male', '94273148', '357 Pasir Panjang Rd');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('sherry', 'S9378453H', 'patient', 'Sherry', 'Loh', '28/05/1995', 'female', '94762049', '26 Prince Georges Park');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('zac', 'S9847395J', 'patient', 'Zachary', 'Chan', '07/03/1998', 'male', '93856723', '125 College Ave East');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('hugh', 'S1895867A', 'doctor', 'Hugh', 'Anderson', '17/08/1948', 'male', '93794857', '521 Bukit Batok Street');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('damith', 'S8473287L', 'doctor', 'Damith', 'Rajapakse', '09/11/1975', 'male', '93645532', 'No.2 Jurong East Street');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('chris', 'A0493891F', 'receptionist', 'Christina', 'Carbunaru', '06/04/1990', 'female', '92463736', '1 Ah Moi Road');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('david', 'A0482764G', 'receptionist', 'David', 'Johnson', '18/10/1986', 'male', '93746555', '302 Tiong Bahru Rd');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('steve', 'H1970941X', 'cashier', 'Steven', 'Halim', '27/07/1963', 'male', '96857344', '257 Selegie Road');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('reza', 'H9837485W', 'cashier', 'Reza', 'Shokri', '19/09/1968', 'male', '98337465', '33 Jalan Minggu');

-- insert appointments data
INSERT INTO APP_ADMIN.APPOINTMENTS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME)
VALUES ('sean', 'hugh', 'chris', TO_DATE('22/03/2021 09:30', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.APPOINTMENTS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME)
VALUES ('hengd', 'hugh', 'chris', TO_DATE('07/09/2020 10:30', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.APPOINTMENTS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME)
VALUES ('hengd', 'damith', 'chris', TO_DATE('21/06/2021 10:00', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.APPOINTMENTS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME)
VALUES ('sherry', 'damith', 'david', TO_DATE('18/05/2020 08:30', 'DD/MM/YYYY HH:MI'));

-- insert consultations data
INSERT INTO APP_ADMIN.CONSULTATIONS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, APPOINTMENT_ID, TIME_START, TIME_END, INTERNAL_NOTES)
VALUES ('hengd', 'hugh', 'chris', 1, TO_DATE('07/09/2020 10:35', 'DD/MM/YYYY HH:MI'), TO_DATE('07/09/2020 12:00', 'DD/MM/YYYY HH:MI'), 'this is a dummy internal note');

INSERT INTO APP_ADMIN.CONSULTATIONS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME_START)
VALUES ('hengd', 'hugh', 'david', TO_DATE('21/09/2020 14:00', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.CONSULTATIONS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, APPOINTMENT_ID, TIME_START, TIME_END, INTERNAL_NOTES)
VALUES ('sherry', 'damith', 'david', 4, TO_DATE('18/05/2020 08:30', 'DD/MM/YYYY HH:MI'), TO_DATE('18/05/2020 10:30', 'DD/MM/YYYY HH:MI'), 'this is a dummy internal note');

-- insert payments data
INSERT INTO APP_ADMIN.PAYMENTS (CASHIER_NAME, CONSULTATION_ID, AMOUNT, STATUS)
VALUES ('steve', 1, 58.89, 'unpaid');

INSERT INTO APP_ADMIN.PAYMENTS (CASHIER_NAME, CONSULTATION_ID, AMOUNT, STATUS)
VALUES ('steve', 3, 124.53, 'paid');

-- insert records data
INSERT INTO APP_ADMIN.RECORDS (CONSULTATION_ID, RECORD_TYPE, RESULTS)
VALUES (1, 'X-ray', 'Healthy lungs');

INSERT INTO APP_ADMIN.RECORDS (CONSULTATION_ID, RECORD_TYPE, RESULTS)
VALUES (1, 'MRI', 'Moderate brain injury');

INSERT INTO APP_ADMIN.RECORDS (CONSULTATION_ID, RECORD_TYPE, RESULTS)
VALUES (3, 'X-ray', 'Healthy chest');

COMMIT;

-- Adds the corresponding database users.
CREATE USER hengd IDENTIFIED BY hengd;
CREATE USER sean  IDENTIFIED BY sean;
CREATE USER hugh  IDENTIFIED BY hugh;
CREATE USER chris IDENTIFIED BY chris;
CREATE USER steve IDENTIFIED BY steve;

GRANT CREATE SESSION, CONNECT, RESOURCE TO hengd, sean, hugh, chris, steve;

GRANT SELECT, INSERT, UPDATE, DELETE ON app_admin.users TO hengd, sean, hugh, chris, steve;
GRANT SELECT, INSERT, UPDATE, DELETE ON app_admin.appointments TO hengd, sean, hugh, chris, steve;
GRANT SELECT, INSERT, UPDATE, DELETE ON app_admin.consultations TO hengd, sean, hugh, chris, steve;
GRANT SELECT, INSERT, UPDATE, DELETE ON app_admin.payments TO hengd, sean, hugh, chris, steve;
GRANT SELECT, INSERT, UPDATE, DELETE ON app_admin.records TO hengd, sean, hugh, chris, steve;
