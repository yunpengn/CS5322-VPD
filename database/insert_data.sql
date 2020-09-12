INSERT INTO patients (nric, name, dob, gender, phone, address)
VALUES ('s4736343h', 'Ding Heng', '13/11/1992', 1, '85556669', '20 Heng Mui Keng Terrace');

INSERT INTO patients (nric, name, dob, gender, phone, address)
VALUES ('s6173429e', 'Sean Yap', '20/08/1994', 1, '94273148', '357 Pasir Panjang Rd');

INSERT INTO staff (name, gender, staff_type)
VALUES ('Hugh Anderson', 1, 0);

INSERT INTO staff (name, gender, staff_type)
VALUES ('Christina Carbunaru', 0, 1);

INSERT INTO staff (name, gender, staff_type)
VALUES ('Steven Halim', 1, 2);

INSERT INTO appointments (patient_id, doctor_id, receptionist_id, time)
VALUES (5, 1, 3, TO_DATE('07/09/2020 10:30', 'DD/MM/YYYY HH:MI'));

SELECT TO_CHAR(time, 'DD/MM/YYYY HH:MI') from appointments where id=1;

INSERT INTO consultations (patient_id, doctor_id, receptionist_id, appointment_id, time_start)
VALUES (5, 1, 3, 1, TO_DATE('07/09/2020 10:35', 'DD/MM/YYYY HH:MI'));

INSERT INTO consultations (patient_id, doctor_id, receptionist_id, time_start, time_end, internal_notes)
VALUES (4, 1, 3, TO_DATE('07/09/2020 01:30', 'DD/MM/YYYY HH:MI'), TO_DATE('07/09/2020 01:40', 'DD/MM/YYYY HH:MI'), 'X-ray');

INSERT INTO payments (cashier_id, consultation_id, amount)
VALUES (2, 2, 58.85);

INSERT INTO records (consultation_id, record_type, results)
VALUES (2, 0, 'healthy lungs');
