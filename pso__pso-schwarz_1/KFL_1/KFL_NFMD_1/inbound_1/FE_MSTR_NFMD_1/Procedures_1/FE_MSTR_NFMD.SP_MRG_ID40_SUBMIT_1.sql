CREATE OR REPLACE PROCEDURE FE_MSTR_NFMD.SP_MRG_ID40_SUBMIT(P_YEAR_ID FLOAT, P_WEEK_ID FLOAT,P_MANDANT_ID FLOAT, P_USER_ID VARCHAR(255))
RETURNS STRING
LANGUAGE JAVASCRIPT
COMMENT='Submits ID40/ID50 records for a week'
EXECUTE AS OWNER
AS $$


var sql_check = `
SELECT COUNT(1) FROM (SELECT TOP 1 * FROM FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_1
WHERE year_id = :1 AND week_id = :2 AND MANDANT_ID = :3
AND (manual_markdown_price > VK_AKTION_BRUTTO
     OR manual_markdown_price IS NULL
     OR manual_markdown_price <= 0
     OR (PREVIOUS_SUBMITTED_PRICE IS NOT NULL AND round(manual_markdown_price,2) > PREVIOUS_SUBMITTED_PRICE)))`;
	 
var stmt_check = snowflake.createStatement({
      sqlText : sql_check, binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID]});
	  
var check = stmt_check.execute();

check.next();

var check_val = check.getColumnValue(1);

var sql_date_check = `SELECT COUNT(1) FROM (SELECT TOP 1 *
FROM FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_1 fview
LEFT JOIN FE_MSTR_NFMD.MV_HADOOP_PARAMETERS_1 prms 
ON fview.MANDANT_ID = prms.MANDANT_ID
WHERE year_id = :1 AND week_id = :2 AND fview.MANDANT_ID = :3
AND valid_from NOT BETWEEN NEXT_DAY(CURRENT_DATE() , prms.DISCOUNT_DAYS) 
											    AND dateadd(DAY,6,NEXT_DAY(CURRENT_DATE(),prms.DISCOUNT_DAYS)))`;
																																	 
var stmt_date_check = snowflake.createStatement({
      sqlText : sql_date_check, binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID]});
	  
var date_check = stmt_date_check.execute();

date_check.next();

var date_check_val = date_check.getColumnValue(1);

if ( check_val == 0 && date_check_val == 0){
var sql_stmt = `MERGE INTO
        CORE.TS_ID40_FINAL_SUBMIT_1 f
        USING FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_1 wb ON
            (f.YEAR_ID = wb.YEAR_ID
            AND f.WEEK_ID = wb.WEEK_ID
            AND f.MANDANT_ID = wb.MANDANT_ID
            AND f.SKU_ID = wb.SKU_ID
            AND f.WUP_ID = wb.WUP_ID
            AND JF_SUBMITTED IS NOT NULL
            AND f.LATEST_TRANSFER_DATE = (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK_1 WHERE MANDANT_ID = :3)
            AND JF_SUBMITTED = 0 )
        WHEN MATCHED
          AND wb.YEAR_ID = :1
          AND wb.WEEK_ID = :2
          AND wb.MANDANT_ID = :3
          AND round(wb.manual_markdown_price, 2) < COALESCE(wb.PREVIOUS_SUBMITTED_PRICE,round(wb.VK_AKTION_BRUTTO , 2) )
          AND (f.SUBMITTED_PRICE <> round(wb.MANUAL_MARKDOWN_PRICE,2) OR wb.valid_from <> f.VALID_FROM_DATE)
         THEN
            UPDATE
                SET
                f.CREATED_AT = CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                f.USER_ID = :4,
                f.SUBMITTED_PRICE = round(wb.manual_markdown_price,2),
                f.valid_from_date = wb.valid_from,
                f.SRC_MD_PRICE_OPT = wb.SRC_MD_PRICE_OPT
        WHEN MATCHED
          AND wb.YEAR_ID = :1
          AND wb.WEEK_ID = :2
          AND wb.MANDANT_ID = :3
          AND round(wb.manual_markdown_price, 2) = COALESCE(wb.PREVIOUS_SUBMITTED_PRICE,round(wb.VK_AKTION_BRUTTO , 2) ) 
          AND (f.SUBMITTED_PRICE <> round(wb.MANUAL_MARKDOWN_PRICE,2) OR wb.valid_from <> f.VALID_FROM_DATE)
       THEN DELETE  
        
        WHEN NOT MATCHED
            AND wb.YEAR_ID = :1
            AND wb.WEEK_ID = :2
            AND wb.MANDANT_ID = :3
            AND round(wb.manual_markdown_price, 2) <> round(wb.VK_AKTION_BRUTTO , 2)
            AND round(wb.manual_markdown_price, 2) <> COALESCE (round(wb.previous_submitted_price, 2) ,0)
          THEN
              INSERT (YEAR_ID, WEEK_ID, MANDANT_ID, AKTION_ID,SKU_ID, WUP_ID, CREATED_AT, USER_ID, SUBMITTED_PRICE, VALID_FROM_DATE, LATEST_TRANSFER_DATE, SRC_MD_PRICE_OPT)
              VALUES (YEAR_ID,
                      WEEK_ID,
                      MANDANT_ID,
                      AKTION_ID,
                      SKU_ID,
                      WUP_ID,
                      CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                      :4,
                      manual_markdown_price,
                      valid_from,
                      (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK_1 WHERE MANDANT_ID = :3),
                      SRC_MD_PRICE_OPT)`;
var stmt = snowflake.createStatement({
      sqlText : sql_stmt, binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_USER_ID]});
stmt.execute();

var sql_stmt2 = `INSERT INTO CORE.TS_ID40_SUBMIT_LOG_1 (YEAR_ID, WEEK_ID, MANDANT_ID, DAT_CREATED, USER_ID)VALUES(:1, :2, :3, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :4)`;
var stmt2 = snowflake.createStatement({
      sqlText : sql_stmt2, binds: [P_YEAR_ID, P_WEEK_ID,P_MANDANT_ID,P_USER_ID]});
stmt2.execute();

var sql_commit = "COMMIT";
      snowflake.createStatement({
        sqlText: sql_commit
        }).execute();
}
else
{
 throw "A price is null, zero, negative, higher than the inital price, higher than the previous submitted and loaded price or a valid from date is incorrect"
}
$$;
