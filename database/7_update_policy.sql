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

    IF    user_role = 'admin' THEN
        cond := '';
    ELSE
        cond := '1 = 2';
    END IF;

    RETURN cond;
END update_users_columns;

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
            sec_relevant_cols => 'user_name,role_type,created_at,updated_at',
            statement_types   => 'update',
            update_check      => true);

END;
