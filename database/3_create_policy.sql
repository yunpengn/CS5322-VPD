-- Defines package.
CREATE OR REPLACE package app_pkg is
    procedure set_app_ctx is BEGIN
        DBMS_SESSION.SET_CONTEXT('app_ctx', 'user_name', user);
    end;
end;

-- Defines application context.
CREATE OR REPLACE context app_ctx USING app_pkg;

-- Defines trigger.

-- Defines functions.

-- Attaches policies.
BEGIN

end;
