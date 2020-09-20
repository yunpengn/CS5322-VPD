-- Inserts sample data.
INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('hengd', 'S4736343H', 'patient', 'Ding Heng', 'Lim', '13/11/1992', 'male', '85556669', '20 Heng Mui Keng Terrace');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('sean', 'S6173429E', 'patient', 'Sean', 'Yap', '20/08/1994', 'male', '94273148', '357 Pasir Panjang Rd');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, GENDER)
VALUES ('hugh', 'S1895867A', 'doctor', 'Hugh', 'Anderson', 'male');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, GENDER)
VALUES ('chris', 'A0493891F', 'receptionist', 'Christina', 'Carbunaru', 'female');

INSERT INTO APP_ADMIN.USERS (USER_NAME, NRIC, ROLE_TYPE, FIRST_NAME, LAST_NAME, GENDER)
VALUES ('steve', 'H1970941X', 'cashier', 'Steven', 'Halim', 'male');

INSERT INTO APP_ADMIN.APPOINTMENTS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME)
VALUES ('hengd', 'hugh', 'chris', TO_DATE('07/09/2020 10:30', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.CONSULTATIONS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, APPOINTMENT_ID, TIME_START, INTERNAL_NOTE)
VALUES ('hengd', 'hugh', 'chris', 1, TO_DATE('07/09/2020 10:35', 'DD/MM/YYYY HH:MI'), 'this is a dummy internal note');

INSERT INTO APP_ADMIN.PAYMENTS (CASHIER_NAME, CONSULTATION_ID, AMOUNT, STATUS)
VALUES ('steve', 1, 58.89, 'unpaid');

INSERT INTO APP_ADMIN.RECORDS (CONSULTATION_ID, RECORD_TYPE, RESULTS)
VALUES (1, 'X-ray', 'Healthy lungs');

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
