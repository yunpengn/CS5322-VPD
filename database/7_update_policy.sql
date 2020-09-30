-- Defines functions.
CREATE OR REPLACE FUNCTION update_users(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'                                                                                  THEN
    cond := '';
  ELSIF user_role = 'patient' OR user_role = 'doctor' OR user_role = 'receptionist' OR user_role = 'cashier' THEN
    cond := 'user_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END update_users;

CREATE OR REPLACE FUNCTION update_users_columns(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');
  cond := '1 = 2';

  RETURN cond;
END update_users_columns;

CREATE OR REPLACE FUNCTION update_appointments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'        THEN
    cond := '';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END update_appointments;

CREATE OR REPLACE FUNCTION update_consultations(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'  THEN
    cond := '';
  ELSIF user_role = 'doctor' THEN
    cond := 'doctor_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END update_consultations;

CREATE OR REPLACE FUNCTION update_consultations_columns(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(100);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin' THEN
    cond := '';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END update_consultations_columns;

CREATE OR REPLACE FUNCTION update_payments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF    user_role = 'admin'   THEN
    cond := '';
  ELSIF user_role = 'cashier' THEN
    cond := 'cashier_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END update_payments;

CREATE OR REPLACE FUNCTION update_payments_columns(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF    user_role = 'admin' THEN
        cond := '';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END update_payments_columns;

CREATE OR REPLACE FUNCTION update_records(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
  cond VARCHAR2(200);
  user_role VARCHAR(12);
BEGIN
  user_role := SYS_CONTEXT('app_ctx', 'user_role');

  IF user_role = 'admin' THEN
    cond := '';
  ELSE
    cond := '1 = 2';
  END IF;

  RETURN cond;
END update_records;

-- Attaches policies.
BEGIN
  DBMS_RLS.ADD_POLICY(
          object_schema   => 'app_admin',
          object_name     => 'users',
          policy_name     => 'policy_update_users',
          policy_function => 'update_users',
          statement_types => 'update',
          update_check    => true);

  DBMS_RLS.ADD_POLICY(
          object_schema     => 'app_admin',
          object_name       => 'users',
          policy_name       => 'policy_update_users_columns',
          policy_function   => 'update_users_columns',
          sec_relevant_cols => 'role_type',
          statement_types   => 'update',
          update_check      => true);

  DBMS_RLS.ADD_POLICY(
          object_schema   => 'app_admin',
          object_name     => 'appointments',
          policy_name     => 'policy_update_appointments',
          policy_function => 'update_appointments',
          statement_types => 'update',
          update_check    => true);

  DBMS_RLS.ADD_POLICY(
          object_schema   => 'app_admin',
          object_name     => 'consultations',
          policy_name     => 'policy_update_consultations',
          policy_function => 'update_consultations',
          statement_types => 'update',
          update_check    => true);

  DBMS_RLS.ADD_POLICY(
          object_schema     => 'app_admin',
          object_name       => 'consultations',
          policy_name       => 'policy_update_consultations_columns',
          policy_function   => 'update_consultations_columns',
          sec_relevant_cols => 'patient_name,doctor_name,receptionist_name,appointment_id,time_start',
          statement_types   => 'update',
          update_check      => true);

  DBMS_RLS.ADD_POLICY(
          object_schema   => 'app_admin',
          object_name     => 'payments',
          policy_name     => 'policy_update_payments',
          policy_function => 'update_payments',
          statement_types => 'update',
          update_check    => true);

  DBMS_RLS.ADD_POLICY(
          object_schema     => 'app_admin',
          object_name       => 'payments',
          policy_name       => 'policy_update_payments_columns',
          policy_function   => 'update_payments_columns',
          sec_relevant_cols => 'cashier_name,amount',
          statement_types   => 'update',
          update_check      => true);

  DBMS_RLS.ADD_POLICY(
          object_schema   => 'app_admin',
          object_name     => 'records',
          policy_name     => 'policy_update_records',
          policy_function => 'update_records',
          statement_types => 'update',
          update_check    => true);
END;
