-- todo: handle the "updated_at" field as "ON UPDATE" clause is not available
-- todo: add constraints on the matching between staff_type and staff id in appointments etc. tables

-- Switches to the correct user.
connect app_admin;

-- Creates new tables.
CREATE TABLE patients (
  user_name  VARCHAR(80),
  nric       CHAR(9)      NOT NULL,
  first_name VARCHAR(80)  NOT NULL,
  last_name  VARCHAR(80)  NOT NULL,
  dob        DATE         NOT NULL,
  gender     VARCHAR(6)   NOT NULL,
  phone      CHAR(8)      NOT NULL,
  address    VARCHAR(100) NOT NULL,
  created_at DATE         DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE         DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (user_name),
  UNIQUE (nric),
  CHECK ( gender IN ('male', 'female') )
);

CREATE TABLE staff (
  user_name  VARCHAR(80),
  first_name VARCHAR(80) NOT NULL,
  gender     NUMBER(1)   NOT NULL,
  staff_type VARCHAR(12) NOT NULL,
  created_at DATE        DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE        DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (user_name),
  CHECK ( staff_type IN ('doctor', 'receptionist', 'cashier') )
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
  FOREIGN KEY (patient_name)      REFERENCES patients(user_name),
  FOREIGN KEY (doctor_name)       REFERENCES staff(user_name),
  FOREIGN KEY (receptionist_name) REFERENCES staff(user_name)
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
  FOREIGN KEY (patient_name)      REFERENCES patients(user_name),
  FOREIGN KEY (doctor_name)       REFERENCES staff(user_name),
  FOREIGN KEY (receptionist_name) REFERENCES staff(user_name),
  FOREIGN KEY (appointment_id)    REFERENCES appointments(id)
);

CREATE TABLE payments (
  id              NUMBER        GENERATED AS IDENTITY,
  cashier_name    NUMBER        NOT NULL,
  consultation_id NUMBER        NOT NULL,
  amount          NUMBER(8,2)   NOT NULL,
  status          VARCHAR(10)   DEFAULT 'unpaid' NOT NULL,
  created_at      DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at      DATE          DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cashier_name)    REFERENCES staff(user_name),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id),
  CHECK ( status IN ('unpaid', 'paid', 'refunded') )
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
  CHECK ( record_type IN ('X-ray', 'MRI') )
);
