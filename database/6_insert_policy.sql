-- Defines functions.
CREATE OR REPLACE FUNCTION restrict_users_insert(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'admin' THEN
        cond := '';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END restrict_users_insert;

CREATE OR REPLACE FUNCTION restrict_records_insert(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'doctor' THEN
        cond := 'doctor_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END restrict_records_insert;

CREATE OR REPLACE FUNCTION restrict_appointments_insert(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'receptionist' THEN
        cond := 'time >= CURRENT_TIMESTAMP and receptionist_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END restrict_appointments_insert;

CREATE OR REPLACE FUNCTION restrict_consultations_insert(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'receptionist' THEN
        cond := 'time_start >= CURRENT_TIMESTAMP and receptionist_name = SYS_CONTEXT(''app_ctx'', ''user_name'')';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END restrict_consultations_insert;

CREATE OR REPLACE FUNCTION restrict_payments_insert(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'doctor' THEN
        cond := 'status = ''unpaid''';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END restrict_payments_insert;

-- Attaches policies.
BEGIN
    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'users',
            policy_name     => 'policy_restrict_users_insert',
            policy_function => 'restrict_users_insert',
            statement_types => 'insert',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'records',
            policy_name     => 'policy_restrict_records_insert',
            policy_function => 'restrict_records_insert',
            statement_types => 'insert',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'appointments',
            policy_name     => 'policy_restrict_appointments_insert',
            policy_function => 'restrict_appointments_insert',
            statement_types => 'insert',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'appointments',
            policy_name     => 'policy_restrict_consultations_insert',
            policy_function => 'restrict_consultations_insert',
            statement_types => 'insert',
            update_check    => true);

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'payments',
            policy_name     => 'policy_restrict_payments_insert',
            policy_function => 'restrict_payments_insert',
            statement_types => 'insert',
            update_check    => true);
END;
