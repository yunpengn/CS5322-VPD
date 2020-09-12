-- Defines package.
CREATE OR REPLACE package app_pkg is
    PROCEDURE set_app_ctx AS
        user_name VARCHAR(80);
        user_role VARCHAR(12);
    BEGIN
        user_name := SYS_CONTEXT('USERENV', 'SESSION_USER');
        DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_name', user_name);

        SELECT STAFF_TYPE INTO user_role FROM STAFF WHERE USER_NAME = user_name;
        DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_role', user_role);
    END;
END;

-- Defines application context.
CREATE OR REPLACE context app_ctx USING app_pkg;

-- Defines trigger.
CREATE OR REPLACE TRIGGER logon_set_ctx AFTER LOGON ON DATABASE
BEGIN
    app_pkg.set_app_ctx();
END;

-- Defines functions.

-- Attaches policies.
BEGIN

end;
