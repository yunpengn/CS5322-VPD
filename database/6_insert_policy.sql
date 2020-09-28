-- Defines triggers.
CREATE OR REPLACE trigger check_users_insert BEFORE insert ON users FOR EACH ROW
BEGIN
  IF SYS_CONTEXT('app_ctx', 'user_role') <> 'admin' THEN
    RAISE_APPLICATION_ERROR(40000, 'Only admin can insert to users tables');
  END IF;
END;

CREATE OR REPLACE trigger check_records_insert BEFORE insert ON records FOR EACH ROW
BEGIN
  IF SYS_CONTEXT('app_ctx', 'user_role') <> 'doctor' THEN
    RAISE_APPLICATION_ERROR(40001, 'Only doctor can insert to records tables');
  END IF;
END;

CREATE OR REPLACE trigger check_appointments_insert BEFORE insert ON appointments FOR EACH ROW
BEGIN
  IF SYS_CONTEXT('app_ctx', 'user_role') <> 'receptionist' THEN
    RAISE_APPLICATION_ERROR(40003, 'Only receptionist can insert to appointments tables');
  END IF;

  IF SYS_CONTEXT('app_ctx', 'user_name') <> :NEW.RECEPTIONIST_NAME THEN
    RAISE_APPLICATION_ERROR(40004, 'receptionist_name should be his/her own name');
  END IF;

  IF :NEW.TIME < CURRENT_TIMESTAMP THEN
    RAISE_APPLICATION_ERROR(40005, 'appointment must be in the future');
  END IF;
END;

CREATE OR REPLACE trigger check_consultations_insert BEFORE insert ON consultations FOR EACH ROW
BEGIN
  IF SYS_CONTEXT('app_ctx', 'user_role') <> 'receptionist' THEN
    RAISE_APPLICATION_ERROR(40006, 'Only receptionist can insert to consultations tables');
  END IF;

  IF SYS_CONTEXT('app_ctx', 'user_name') <> :NEW.RECEPTIONIST_NAME THEN
    RAISE_APPLICATION_ERROR(40007, 'receptionist_name should be his/her own name');
  END IF;

  IF :NEW.TIME_START < CURRENT_TIMESTAMP THEN
    RAISE_APPLICATION_ERROR(40008, 'consultation cannot start in the past');
  END IF;
END;

CREATE OR REPLACE trigger check_payments_insert BEFORE insert ON payments FOR EACH ROW
BEGIN
  IF SYS_CONTEXT('app_ctx', 'user_role') <> 'doctor' THEN
    RAISE_APPLICATION_ERROR(40009, 'Only doctor can insert to payments tables');
  END IF;

  IF :NEW.STATUS <> 'unpaid' THEN
    RAISE_APPLICATION_ERROR(40005, 'the initial status of a payment must be unpaid');
  END IF;
END;
