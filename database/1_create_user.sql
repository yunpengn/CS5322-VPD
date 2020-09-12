-- Creates system user.
CREATE USER app_admin IDENTIFIED BY not_admin;

-- Grants necessary privileges.
GRANT create session, create any context, connect, resource TO app_admin;
GRANT execute ON DBMS_SESSION TO app_admin;
GRANT execute ON DBMS_RLS TO app_admin;

-- Grants unlimited table space.
ALTER USER app_admin QUOTA UNLIMITED ON USERS;
