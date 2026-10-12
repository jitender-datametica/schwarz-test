/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   16-01-2024   Aleksander Bialek   Initial Version of procedure cleaning up leftover MSTR created tables in P_LEW_MSI_TEMP (AD WI:568244)
# 1.2   19-01-2024   Aleksander Bialek   Additional condition added to asure that only P_LEW_MSI_TEMP is being cleaned (show tables include also public schema objects)
# 1.3   11-09-2025   Aleksander Bialek   Additional condition added to asure that EK_Security related tables are not being dropped (AD WI:
#                                       
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.p_msi_mstr_tmp_tables_cleanup(OUT out_param STRING)
BEGIN
  DECLARE drop_count INT64 DEFAULT 0;
  DECLARE error_count INT64 DEFAULT 0;
  DECLARE sql_stmt STRING;

  BEGIN
    
    CREATE OR REPLACE TEMP TABLE t_tmp_cleanup_syntax AS
    SELECT 
      CONCAT('DROP TABLE `', table_schema, '.', table_name, '`;') AS syntax,
      TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), creation_time, HOUR) AS HOURS_SINCE_CREATION
    FROM p_lew_msi_temp.INFORMATION_SCHEMA.TABLES
    WHERE TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), creation_time, HOUR) > 2
      AND UPPER(table_schema) = 'P_LEW_MSI_TEMP'
      AND UPPER(table_name) NOT LIKE 'T_SEC_EKWA_NRV_EK%'
    ORDER BY HOURS_SINCE_CREATION DESC
    LIMIT 2000;

    
    FOR table_record IN (SELECT syntax FROM t_tmp_cleanup_syntax)
    DO
      BEGIN
        EXECUTE IMMEDIATE table_record.syntax;
        SET drop_count = drop_count + 1;
      EXCEPTION WHEN ERROR THEN
        
        SET error_count = error_count + 1;
      END;
    END FOR;

    SET out_param = FORMAT('{"Status": "Success", "TablesDropped": %d, "ErrorsIgnored": %d}', drop_count, error_count);

  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;
END;

