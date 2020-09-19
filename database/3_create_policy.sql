-- Defines package.
CREATE OR REPLACE package app_pkg IS
    PROCEDURE set_app_ctx;
END;

CREATE OR REPLACE package body app_pkg is
    PROCEDURE set_app_ctx AS
        user_name VARCHAR(80);
        user_role VARCHAR(12);
    BEGIN
        user_name := SYS_CONTEXT('userenv', 'SESSION_USER');
        DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_name', user_name);

        IF user_name = 'APP_ADMIN' THEN
            DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_role', 'admin');
        ELSE
            SELECT role_type INTO user_role FROM users WHERE USER_NAME = user_name;
            DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_role', user_role);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN NULL;
    END set_app_ctx;
END;

-- Defines application context.
CREATE OR REPLACE context app_ctx USING app_pkg;

-- Defines user login trigger.
CREATE OR REPLACE TRIGGER logon_set_ctx AFTER LOGON ON DATABASE
BEGIN
    app_pkg.set_app_ctx();
END;

-- Defines functions.
CREATE OR REPLACE FUNCTION restrict_users(v_schema IN VARCHAR2, v_obj IN VARCHAR2) RETURN VARCHAR2 AS
    cond VARCHAR2(100);
    user_role VARCHAR(12);
BEGIN
    user_role := SYS_CONTEXT('app_ctx', 'user_role');

    IF    user_role = 'admin'        THEN
        cond = '';
    ELSIF user_role = 'patient'      THEN
        cond = 'user_name = SYS_CONTEXT("app_ctx", "user_name")';
    ELSIF user_role = 'doctor'       THEN
        cond = '';
    ELSIF user_role = 'receptionist' THEN
        cond = '';
    ELSIF user_role = 'cashier'      THEN
        cond = '';
    ELSE
        cond = '1 = 2';
    END IF;

    RETURN cond;
END restrict_users;

-- Attaches policies.
BEGIN
    DBMS_RLS.ADD_POLICY(
        object_schema   => 'app_admin',
        object_name     => 'users',
        policy_name     => 'policy_restrict_users',
        policy_function => 'restrict_users',
        statement_types => 'select, insert, update, delete');
END;
