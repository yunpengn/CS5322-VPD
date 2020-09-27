-- Defines functions.
CREATE OR REPLACE FUNCTION select_users(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSIF user_role = 'patient'      THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'') OR user_name IN (SELECT doctor_name FROM app_admin.consultations WHERE patient_name = SYS_CONTEXT(''app_ctx'', ''user_name''))';
  ELSIF user_role = 'doctor'       THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'') OR user_name IN (SELECT patient_name FROM app_admin.consultations WHERE doctor_name = SYS_CONTEXT(''app_ctx'', ''user_name''))';
  ELSIF user_role = 'receptionist' THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'') OR role_type IN (''patient'', ''doctor'')';
  ELSIF user_role = 'cashier'      THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '';
  END IF;

  RETURN cond;
END select_users;

CREATE OR REPLACE FUNCTION select_users_patient(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF user_role = 'patient'       THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '';
  END IF;

  RETURN cond;
END select_users_patient;

CREATE OR REPLACE FUNCTION select_users_doctor(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF user_role = 'doctor'       THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '';
  END IF;

  RETURN cond;
END select_users_doctor;

CREATE OR REPLACE FUNCTION select_users_receptionist(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF user_role = 'receptionist'       THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '';
  END IF;

  RETURN cond;
END select_users_receptionist;

CREATE OR REPLACE FUNCTION select_records(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSIF user_role = 'patient'      THEN
    cond := 'consultation_id IN (SELECT id FROM consultations WHERE patient_name = SYS_CONTEXT(''app_ctx'', ''user_name''))';
  ELSIF user_role = 'doctor'       THEN
    cond := 'consultation_id IN (SELECT id FROM consultations WHERE doctor_name = SYS_CONTEXT(''app_ctx'', ''user_name''))';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END select_records;

CREATE OR REPLACE FUNCTION select_appointments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSIF user_role = 'patient'      THEN
    cond := 'patient_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSIF user_role = 'doctor'       THEN
    cond := 'doctor_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSIF user_role = 'receptionist' THEN
    cond := 'receptionist_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END select_appointments;

CREATE OR REPLACE FUNCTION select_consultations(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSIF user_role = 'patient'      THEN
    cond := 'patient_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSIF user_role = 'doctor'       THEN
    cond := 'doctor_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSIF user_role = 'receptionist' THEN
    cond := 'receptionist_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END select_consultations;

CREATE OR REPLACE FUNCTION select_consultations_internal_notes(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSIF user_role = 'doctor'       THEN
    cond := '';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END select_consultations_internal_notes;

CREATE OR REPLACE FUNCTION select_payments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSIF user_role = 'patient'      THEN
    cond := 'consultation_id IN (SELECT id FROM app_admin.consultations WHERE patient_name = SYS_CONTEXT(''app_ctx'', ''user_name''))';
  ELSIF user_role = 'cashier'      THEN
    cond := 'cashier_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END select_payments;

-- Attaches policies.
BEGIN
  -- DBMS_RLS.DROP_POLICY('app_admin', 'users', 'policy_select_users');

  DBMS_RLS.ADD_POLICY(
      object_schema   => 'app_admin',
      object_name     => 'users',
      policy_name     => 'policy_select_users',
      policy_function => 'select_users',
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema         => 'app_admin',
      object_name           => 'users',
      policy_name           => 'policy_select_users_patient',
      policy_function       => 'select_users_patient',
      sec_relevant_cols     => 'nric, dob, phone, address',
      sec_relevant_cols_opt => dbms_rls.all_rows,
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema         => 'app_admin',
      object_name           => 'users',
      policy_name           => 'policy_select_users_doctor',
      policy_function       => 'select_users_doctor',
      sec_relevant_cols     => 'nric, phone, address',
      sec_relevant_cols_opt => dbms_rls.all_rows,
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema         => 'app_admin',
      object_name           => 'users',
      policy_name           => 'policy_select_users_receptionist',
      policy_function       => 'select_users_receptionist',
      sec_relevant_cols     => 'address',
      sec_relevant_cols_opt => dbms_rls.all_rows,
      statement_types       => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema   => 'app_admin',
      object_name     => 'records',
      policy_name     => 'policy_select_records',
      policy_function => 'select_records',
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema   => 'app_admin',
      object_name     => 'appointments',
      policy_name     => 'policy_select_appointments',
      policy_function => 'select_appointments',
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema   => 'app_admin',
      object_name     => 'consultations',
      policy_name     => 'policy_select_consultations',
      policy_function => 'select_consultations',
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema         => 'app_admin',
      object_name           => 'consultations',
      policy_name           => 'policy_select_consultations_internal_notes',
      policy_function       => 'select_consultations_internal_notes',
      sec_relevant_cols     => 'internal_notes',
      sec_relevant_cols_opt => dbms_rls.all_rows,
      statement_types => 'select');

  DBMS_RLS.ADD_POLICY(
      object_schema   => 'app_admin',
      object_name     => 'payments',
      policy_name     => 'policy_select_payments',
      policy_function => 'select_payments',
      statement_types => 'select');
END;
