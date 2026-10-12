CREATE OR REPLACE PROCEDURE KFL_PRODUCTION.META.SP_AKT_MSI_USER_PURGE() 
    RETURNS VARCHAR(16777216) LANGUAGE JAVASCRIPT
    AS $$

// 
var sql_purge = `DELETE FROM DBP_MSI_DATA.AKT_MSI_USER_1
                   WHERE session_id  
                   in (
                   select distinct 
                    t1.session_id
                    --start_time,
                    --end_time
                    from dbp_msi_Data.akt_msi_user_1 t1_1
                    JOIN snowflake.account_usage.query_history_1 t2
                    on t1.session_id = t2.session_id
                    WHERE 
                    to_date(start_time) = current_date()
                    and end_time < DATEADD(hour, - 1, CURRENT_TIMESTAMP()))`;
  
var statement_purge = snowflake.createStatement( {sqlText: sql_purge} );
var result_purge    = statement_purge.execute();
return result_purge;
    $$