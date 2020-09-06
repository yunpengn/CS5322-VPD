-- todo: handle the "updated_at" field as "ON UPDATE" clause is not available
-- todo: add constraints on the matching between staff_type and staff id in appointments etc. tables
CREATE TABLE patients (
  id NUMBER GENERATED AS IDENTITY,
  nric CHAR(9) UNIQUE NOT NULL,
  name VARCHAR(80) NOT NULL,
  dob DATE NOT NULL,
  gender NUMBER(1) NOT NULL,
  phone CHAR(8) NOT NULL,
  address VARCHAR(100) NOT NULL,
  created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
)

CREATE TABLE staff (
  id NUMBER GENERATED AS IDENTITY,
  name VARCHAR(80) NOT NULL,
  gender NUMBER(1) NOT NULL,
  staff_type NUMBER(1) NOT NULL,
  created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id)
)

CREATE TABLE appointments (
  id NUMBER GENERATED AS IDENTITY,
  patient_id NUMBER NOT NULL,
  doctor_id NUMBER NOT NULL,
  receptionist_id NUMBER NOT NULL,
  time DATE NOT NULL,
  created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (doctor_id) REFERENCES staff(id),
  FOREIGN KEY (receptionist_id) REFERENCES staff(id)
)

CREATE TABLE consultations (
  id NUMBER GENERATED AS IDENTITY,
  patient_id NUMBER NOT NULL,
  doctor_id NUMBER NOT NULL,
  receptionist_id NUMBER NOT NULL,
  appointment_id NUMBER,
  time_start DATE NOT NULL,
  time_end DATE,
  internal_notes VARCHAR(200),
  created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (doctor_id) REFERENCES staff(id),
  FOREIGN KEY (receptionist_id) REFERENCES staff(id),
  FOREIGN KEY (appointment_id) REFERENCES appointments(id)
)

CREATE TABLE payments (
  id NUMBER GENERATED AS IDENTITY,
  cashier_id NUMBER NOT NULL,
  consultation_id NUMBER NOT NULL,
  amount NUMBER(8,2) NOT NULL,
  status NUMBER(1) DEFAULT 0 NOT NULL,
  created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cashier_id) REFERENCES staff(id),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id)
)

CREATE TABLE records (
  id NUMBER GENERATED AS IDENTITY,
  consultation_id NUMBER NOT NULL,
  record_type NUMBER(2) NOT NULL,
  results VARCHAR(200) NOT NULL,
  created_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (consultation_id) REFERENCES consultations(id)
)
