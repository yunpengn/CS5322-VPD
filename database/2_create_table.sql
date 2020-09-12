-- todo: handle the "updated_at" field as "ON UPDATE" clause is not available

-- Creates new tables.
CREATE TABLE users (
   user_name  VARCHAR(80),
   role_type  VARCHAR(12)  NOT NULL,
   nric       CHAR(9)      NOT NULL,
   first_name VARCHAR(80)  NOT NULL,
   last_name  VARCHAR(80)  NOT NULL,
   dob        DATE,
   gender     VARCHAR(6)   NOT NULL,
   phone      CHAR(8),
   address    VARCHAR(100),
   created_at DATE         DEFAULT CURRENT_TIMESTAMP NOT NULL,
   updated_at DATE         DEFAULT CURRENT_TIMESTAMP NOT NULL,
   PRIMARY KEY (user_name),
   UNIQUE      (nric, role_type),
   CHECK       (role_type IN ('patient', 'doctor', 'receptionist', 'cashier')),
   CHECK       (gender    IN ('male', 'female'))
);

CREATE TABLE appointments (
  id                NUMBER      GENERATED AS IDENTITY,
  patient_name      VARCHAR(80) NOT NULL,
  doctor_name       VARCHAR(80) NOT NULL,
  receptionist_name VARCHAR(80) NOT NULL,
  time              DATE        NOT NULL,
  created_at        DATE        DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at        DATE        DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (patient_name)      REFERENCES users(user_name),
  FOREIGN KEY (doctor_name)       REFERENCES users(user_name),
  FOREIGN KEY (receptionist_name) REFERENCES users(user_name)
);

CREATE TABLE consultations (
  id                NUMBER        GENERATED AS IDENTITY,
  patient_name      VARCHAR(80)   NOT NULL,
  doctor_name       VARCHAR(80)   NOT NULL,
  receptionist_name VARCHAR(80)   NOT NULL,
  appointment_id    NUMBER,
  time_start        DATE          NOT NULL,
  time_end          DATE,
  internal_notes    VARCHAR(200),
  created_at        DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at        DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (patient_name)      REFERENCES users(user_name),
  FOREIGN KEY (doctor_name)       REFERENCES users(user_name),
  FOREIGN KEY (receptionist_name) REFERENCES users(user_name),
  FOREIGN KEY (appointment_id)    REFERENCES appointments(id)
);

CREATE TABLE payments (
  id              NUMBER        GENERATED AS IDENTITY,
  cashier_name    VARCHAR(80)   NOT NULL,
  consultation_id NUMBER        NOT NULL,
  amount          NUMBER(8,2)   NOT NULL,
  status          VARCHAR(10)   DEFAULT 'unpaid' NOT NULL,
  created_at      DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at      DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cashier_name)    REFERENCES users(user_name),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  CHECK       (status IN ('unpaid', 'paid', 'refunded'))
);

CREATE TABLE records (
  id              NUMBER        GENERATED AS IDENTITY,
  consultation_id NUMBER        NOT NULL,
  record_type     VARCHAR(10)   NOT NULL,
  results         VARCHAR(200)  NOT NULL,
  created_at      DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at      DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  CHECK       (record_type IN ('X-ray', 'MRI'))
);

-- Uses some triggers to define data constraints.
CREATE OR REPLACE trigger check_appointments_staff BEFORE insert OR update ON appointments FOR EACH ROW
DECLARE
    v_role VARCHAR(12);
BEGIN
    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.PATIENT_NAME;
    IF v_role <> 'doctor' THEN
        RAISE_APPLICATION_ERROR(10001, 'appointments.patient_name is not a patient');
    END IF;

    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.DOCTOR_NAME;
    IF v_role <> 'doctor' THEN
        RAISE_APPLICATION_ERROR(10001, 'appointments.doctor_name is not a doctor');
    END IF;

    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.RECEPTIONIST_NAME;
    IF v_role <> 'receptionist' THEN
        RAISE_APPLICATION_ERROR(10002, 'appointments.receptionist_name is not a receptionist');
    END IF;
END;

CREATE OR REPLACE trigger check_consultations_staff BEFORE insert OR update ON consultations FOR EACH ROW
DECLARE
    v_role VARCHAR(12);
BEGIN
    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.PATIENT_NAME;
    IF v_role <> 'doctor' THEN
        RAISE_APPLICATION_ERROR(10001, 'consultations.patient_name is not a patient');
    END IF;

    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.DOCTOR_NAME;
    IF v_role <> 'doctor' THEN
        RAISE_APPLICATION_ERROR(20001, 'consultations.doctor_name is not a doctor');
    END IF;

    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.RECEPTIONIST_NAME;
    IF v_role <> 'receptionist' THEN
        RAISE_APPLICATION_ERROR(20002, 'consultations.receptionist_name is not a receptionist');
    END IF;
END;

CREATE OR REPLACE trigger check_payments_staff BEFORE insert OR update ON payments FOR EACH ROW
DECLARE
    v_role VARCHAR(12);
BEGIN
    SELECT role_type INTO v_role FROM users WHERE user_name = :NEW.CASHIER_NAME;
    IF v_role <> 'cashier' THEN
        RAISE_APPLICATION_ERROR(30003, 'payments.cashier_name is not a doctor');
    END IF;
END;
