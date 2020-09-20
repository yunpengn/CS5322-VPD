-- Defines package.
CREATE OR REPLACE package app_pkg IS
    PROCEDURE set_app_ctx;
END;

CREATE OR REPLACE package body app_pkg is
    PROCEDURE set_app_ctx AS
        v_user_name VARCHAR(80);
        v_user_role VARCHAR(12);
    BEGIN
        v_user_name := LOWER(SYS_CONTEXT('userenv', 'SESSION_USER'));
        DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_name', v_user_name);

        IF v_user_name = 'app_admin' THEN
            DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_role', 'admin');
        ELSE
            SELECT role_type INTO v_user_role FROM app_admin.users WHERE USER_NAME = v_user_name;
            DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_role', v_user_role);
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
