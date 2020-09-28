-- Defines functions.
CREATE OR REPLACE FUNCTION insert_users(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
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
END insert_users;

CREATE OR REPLACE FUNCTION insert_records(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(200);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'admin' OR user_role = 'doctor' THEN
        cond := '';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END insert_records;

CREATE OR REPLACE FUNCTION insert_appointments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(200);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'admin' THEN
        cond := '';
    ELSIF user_role = 'receptionist' THEN
        cond := 'receptionist_name = SYS_CONTEXT(''app_ctx'', ''user_name'') AND time >= CURRENT_TIMESTAMP';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END insert_appointments;

CREATE OR REPLACE FUNCTION insert_consultations(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(200);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'admin' THEN
        cond := '';
    ELSIF user_role = 'receptionist' THEN
        cond := 'receptionist_name = SYS_CONTEXT(''app_ctx'', ''user_name'') AND time_start >= CURRENT_TIMESTAMP';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END insert_consultations;

CREATE OR REPLACE FUNCTION insert_payments(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(200);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'admin' THEN
        cond := '';
    ELSIF user_role = 'doctor' THEN
        cond := 'status = ''unpaid''';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END insert_payments;

-- Attaches policies.
BEGIN
    DBMS_RLS.ADD_POLICY(
        object_schema   => 'app_admin',
        object_name     => 'users',
        policy_name     => 'policy_insert_users',
        policy_function => 'insert_users',
        statement_types => 'insert',
        update_check    => true);

    DBMS_RLS.ADD_POLICY(
        object_schema   => 'app_admin',
        object_name     => 'records',
        policy_name     => 'policy_insert_records',
        policy_function => 'insert_records',
        statement_types => 'insert',
        update_check    => true);

    DBMS_RLS.ADD_POLICY(
        object_schema   => 'app_admin',
        object_name     => 'appointments',
        policy_name     => 'policy_insert_appointments',
        policy_function => 'insert_appointments',
        statement_types => 'insert',
        update_check    => true);

    DBMS_RLS.ADD_POLICY(
        object_schema   => 'app_admin',
        object_name     => 'consultations',
        policy_name     => 'policy_insert_consultations',
        policy_function => 'insert_consultations',
        statement_types => 'insert',
        update_check    => true);

    DBMS_RLS.ADD_POLICY(
        object_schema   => 'app_admin',
        object_name     => 'payments',
        policy_name     => 'policy_insert_payments',
        policy_function => 'insert_payments',
        statement_types => 'insert',
        update_check    => true);
END;
