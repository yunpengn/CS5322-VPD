-- Kills all active connections.
BEGIN
    FOR r IN (select sid, serial# from v$session where username = 'APP_ADMIN') LOOP
        EXECUTE IMMEDIATE 'alter system kill session ''' || r.sid  || ','  || r.serial# || ''' immediate';
    END LOOP;
END;

-- Drops existing user & records.
DROP USER app_admin CASCADE;
