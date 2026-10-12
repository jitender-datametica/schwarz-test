CREATE OR REPLACE PROCEDURE `dbp_macro.m_insert_l_bis_ldap` (MA_LDAP STRING)
BEGIN
  -- Declare a variable to check for existence
  DECLARE exists_count INT64;

  -- Start a transaction
  BEGIN TRANSACTION;

  -- Check if the LDAP entry already exists
  SET exists_count = (
    SELECT COUNT(1) 
    FROM `dbp_security.l_bis_ldap_1` 
    WHERE ma_ldap = MA_LDAP
  );

  IF exists_count > 0 THEN
    -- Rollback if it exists and return the warning message
    ROLLBACK TRANSACTION;
    SELECT 'ACHTUNG: eingegebener Einkäufer (LDAP) existiert bereits.' AS result;
  ELSE
    -- Perform the insert
    INSERT INTO `dbp_security.l_bis_ldap_1` (ma_ldap) 
    VALUES (MA_LDAP);

    -- Commit the changes
    COMMIT TRANSACTION;
    SELECT 'Success' AS result;
  END IF;

EXCEPTION WHEN ERROR THEN
  -- Rollback in case of any system error during execution
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;
END;