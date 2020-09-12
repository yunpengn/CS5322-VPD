-- Creates system user.
CREATE USER app_admin IDENTIFIED BY not_admin;

-- Grants necessary privileges.
GRANT resource, connect TO app_admin;
GRANT execute ON DBMS_RLS TO app_admin;
GRANT SELECT ANY DICTIONARY to app_admin;

-- Grants unlimited table space.
ALTER USER app_admin QUOTA UNLIMITED ON USERS;
