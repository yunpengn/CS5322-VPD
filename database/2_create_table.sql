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
  PRIMARY KEY (id),
  UNIQUE      (consultation_id),
  FOREIGN KEY (cashier_name)    REFERENCES users(user_name),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  CHECK       (status IN ('unpaid', 'paid', 'refunded'))
);

CREATE TABLE records (
  id              NUMBER        GENERATED AS IDENTITY,
  consultation_id NUMBER        NOT NULL,
  record_type     VARCHAR(10)   NOT NULL,
  results         VARCHAR(200)  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  CHECK       (record_type IN ('X-ray', 'MRI'))
);
