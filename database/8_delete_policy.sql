-- Defines functions.
CREATE OR REPLACE FUNCTION restrict_users_delete(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN
    RETURN '1 = 2';
END restrict_users_delete;

CREATE OR REPLACE FUNCTION restrict_records_delete(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN
    RETURN '1 = 2';
END restrict_records_delete;

CREATE OR REPLACE FUNCTION restrict_appointments_delete(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF user_role = 'receptionist' THEN
        cond := 'time > CURRENT_TIMESTAMP';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END restrict_appointments_delete;

CREATE OR REPLACE FUNCTION restrict_consultations_delete(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN
    RETURN '1 = 2';
END restrict_consultations_delete;

CREATE OR REPLACE FUNCTION restrict_payments_delete(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN
    RETURN '1 = 2';
END restrict_payments_delete;

-- Attaches policies.
BEGIN
    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'users',
            policy_name     => 'policy_restrict_users_delete',
            policy_function => 'restrict_users_delete',
            statement_types => 'delete');

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'records',
            policy_name     => 'policy_restrict_records_delete',
            policy_function => 'restrict_records_delete',
            statement_types => 'delete');

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'appointments',
            policy_name     => 'policy_restrict_appointments_delete',
            policy_function => 'restrict_appointments_delete',
            statement_types => 'delete');

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'consultations',
            policy_name     => 'policy_restrict_consultations_delete',
            policy_function => 'restrict_consultations_delete',
            statement_types => 'delete');

    DBMS_RLS.ADD_POLICY(
            object_schema   => 'app_admin',
            object_name     => 'payments',
            policy_name     => 'policy_restrict_payments_delete',
            policy_function => 'restrict_payments_delete',
            statement_types => 'delete');
END;
