-- Kills all active connections.
SELECT SID, SERIAL# FROM V$SESSION WHERE USERNAME = 'APP_ADMIN';
ALTER SYSTEM KILL SESSION '72, 60140';

-- Drops existing user & records.
DROP USER app_admin CASCADE;
