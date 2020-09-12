-- Inserts sample data.
INSERT INTO APP_ADMIN.PATIENTS (USER_NAME, NRIC, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('hengd', 's4736343h', 'Ding Heng', 'Lim', '13/11/1992', 'male', '85556669', '20 Heng Mui Keng Terrace');

INSERT INTO APP_ADMIN.PATIENTS (USER_NAME, NRIC, FIRST_NAME, LAST_NAME, DOB, GENDER, PHONE, ADDRESS)
VALUES ('sean', 's6173429e', 'Sean', 'Yap', '20/08/1994', 'male', '94273148', '357 Pasir Panjang Rd');

INSERT INTO APP_ADMIN.STAFF (USER_NAME, FIRST_NAME, LAST_NAME, GENDER, STAFF_TYPE)
VALUES ('hugh', 'Hugh', 'Anderson', 'male', 'doctor');

INSERT INTO APP_ADMIN.STAFF (USER_NAME, FIRST_NAME, LAST_NAME, GENDER, STAFF_TYPE)
VALUES ('chris', 'Christina', 'Carbunaru', 'female', 'receptionist');

INSERT INTO APP_ADMIN.STAFF (USER_NAME, FIRST_NAME, LAST_NAME, GENDER, STAFF_TYPE)
VALUES ('steve', 'Steven', 'Halim', 'male', 'cashier');

INSERT INTO APP_ADMIN.APPOINTMENTS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, TIME)
VALUES ('hengd', 'hugh', 'chris', TO_DATE('07/09/2020 10:30', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.CONSULTATIONS (PATIENT_NAME, DOCTOR_NAME, RECEPTIONIST_NAME, APPOINTMENT_ID, TIME_START)
VALUES ('hengd', 'hugh', 'chris', 1, TO_DATE('07/09/2020 10:35', 'DD/MM/YYYY HH:MI'));

INSERT INTO APP_ADMIN.PAYMENTS (CASHIER_NAME, CONSULTATION_ID, AMOUNT, STATUS)
VALUES ('steve', 1, 58.89, 'unpaid');

INSERT INTO APP_ADMIN.RECORDS (CONSULTATION_ID, RECORD_TYPE, RESULTS)
VALUES (1, 'X-ray', 'Healthy lungs');

COMMIT;
