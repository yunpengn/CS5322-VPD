-- Defines functions.
CREATE OR REPLACE FUNCTION restrict_users(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END restrict_users;

CREATE OR REPLACE FUNCTION restrict_records(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END restrict_records;

CREATE OR REPLACE FUNCTION restrict_appointments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END restrict_appointments;

CREATE OR REPLACE FUNCTION restrict_consultations(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END restrict_consultations;

CREATE OR REPLACE FUNCTION restrict_consultations_internal_notes(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END restrict_consultations_internal_notes;

CREATE OR REPLACE FUNCTION restrict_payments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END restrict_payments;

-- Attaches policies.
BEGIN
    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'users',
            policy_name     => 'policy_restrict_users',
            policy_function => 'restrict_users',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'records',
            policy_name     => 'policy_restrict_records',
            policy_function => 'restrict_records',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'appointments',
            policy_name     => 'policy_restrict_appointments',
            policy_function => 'restrict_appointments',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'consultations',
            policy_name     => 'policy_restrict_consultations',
            policy_function => 'restrict_consultations',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema         => 'app_admin',
            object_name           => 'consultations',
            policy_name           => 'policy_restrict_consultations_internal_notes',
            policy_function       => 'restrict_consultations_internal_notes',
            sec_relevant_cols     => 'internal_notes',
            sec_relevant_cols_opt => dbms_rls.all_rows,
            update_check          => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'payments',
            policy_name     => 'policy_restrict_payments',
            policy_function => 'restrict_payments',
            update_check    => true);
END;