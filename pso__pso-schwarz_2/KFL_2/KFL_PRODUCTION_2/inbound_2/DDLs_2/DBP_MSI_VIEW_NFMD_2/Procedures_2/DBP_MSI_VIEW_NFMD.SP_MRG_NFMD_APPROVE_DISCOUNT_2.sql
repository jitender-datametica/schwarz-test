CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_MRG_NFMD_APPROVE_DISCOUNT("P_KJWO_WW" FLOAT, "P_MANDANT_ID" FLOAT, "P_USER_ID" VARCHAR(255))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
COMMENT='Submits ID40/ID50 records for a week'
EXECUTE AS OWNER
AS '



var sql_check = `
SELECT COUNT(1) FROM (SELECT TOP 1 * FROM DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_2
WHERE kjwo_ww = :1 AND  MANDANT_ID = :2
AND discount_type_name = ''nfmd''
AND (manual_markdown_price > SELLING_PRICE_GROSS_LOCAL_VAL
     OR manual_markdown_price IS NULL
     OR manual_markdown_price <= 0
     OR (PREVIOUS_SUBMITTED_PRICE IS NOT NULL AND round(manual_markdown_price,2) > PREVIOUS_SUBMITTED_PRICE)))`;
	 
var stmt_check = snowflake.createStatement({
      sqlText : sql_check, binds: [P_KJWO_WW, P_MANDANT_ID]});
	  
var check = stmt_check.execute();

check.next();

var check_val = check.getColumnValue(1);

var sql_date_check = `SELECT COUNT(1) FROM (SELECT TOP 1 *
FROM DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_2 fview
JOIN DBP_DATA.NFMD_PARAMETER_2 prms 
ON fview.MANDANT_ID = prms.MANDANT_ID
WHERE kjwo_ww = :1 AND  fview.MANDANT_ID = :2
AND discount_type_name = ''nfmd''
AND (remaining_stock_cnt > 0 OR :2 = 5)
AND valid_from NOT BETWEEN NEXT_DAY(CURRENT_DATE() , prms.DISCOUNT_DAY_OF_WEEK) 
											    AND add_months(CURRENT_DATE(),3))`;
																																	 
var stmt_date_check = snowflake.createStatement({
      sqlText : sql_date_check, binds: [P_KJWO_WW,P_MANDANT_ID]});
	  
var date_check = stmt_date_check.execute();

date_check.next();

var date_check_val = date_check.getColumnValue(1);

if ( check_val == 0 && date_check_val == 0){
var sql_stmt = `MERGE INTO
        DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE_2 f
        USING DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_2 wb ON
            (f.KJWO_WW = wb.KJWO_WW
            AND f.MANDANT_ID = wb.MANDANT_ID
            AND f.ART_ID = wb.ART_ID
            AND f.WUP_ID = wb.WUP_ID
            AND COALESCE(f.LAST_TRANSFER_TMSP,''1900-01-01'') = (SELECT  MAX(COALESCE(EXECUTION_TMSP,''1900-01-01'')) AS LAST_SAP_TRANSPER_TMSP 
                  FROM DBP_VIEW.V_MANDANT_2 v1
                  LEFT JOIN DBP_VIEW.V_NFMD_PIPELINE_EXPORT_LOG_2 v2
                  on v1.mandant_id = v2.mandant_id
                  where v1.MANDANT_ID = :2)
            AND wb.discount_type_name = ''nfmd''
            AND (wb.remaining_stock_cnt > 0 OR :2 = 5)
            )
        WHEN MATCHED
          AND wb.KJWO_WW = :1
          AND wb.MANDANT_ID = :2
          AND round(wb.manual_markdown_price, 2) < COALESCE(wb.PREVIOUS_SUBMITTED_PRICE,round(wb.SELLING_PRICE_GROSS_LOCAL_VAL , 2) )
          AND (f.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL  <> round(wb.MANUAL_MARKDOWN_PRICE,2) OR wb.valid_from <> f.MANUAL_PROMO_PRICE_DT )             
          AND wb.discount_type_name = ''nfmd''

         THEN
            UPDATE
                SET
                f.DWH_CREATED_TMSP = CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                f.USER_ID = :3,
                f.WRG_ID = wb.WRG_ID,
                f.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL = round(wb.manual_markdown_price,2),
                f.MANUAL_PROMO_PRICE_DT = wb.valid_from,
                f.MODEL_PRICE_GROSS_LOCAL_VAL = wb.SRC_MODEL_PRICE_GROSS_LOCAL_VAL,
                f.DISCOUNT_TYPE_NAME = wb.discount_type_name
        WHEN MATCHED
          AND wb.KJWO_WW = :1
          AND wb.MANDANT_ID = :2
          AND round(wb.manual_markdown_price, 2) = COALESCE(wb.PREVIOUS_SUBMITTED_PRICE,round(wb.SELLING_PRICE_GROSS_LOCAL_VAL , 2) ) 
          AND (f.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL <> round(wb.MANUAL_MARKDOWN_PRICE,2) OR wb.valid_from <> f.MANUAL_PROMO_PRICE_DT)
       THEN DELETE  
        
        WHEN NOT MATCHED
            AND wb.KJWO_WW = :1
            AND wb.MANDANT_ID = :2
            AND round(wb.manual_markdown_price, 2) <> COALESCE (round(wb.previous_submitted_price, 2) ,0)
            AND wb.discount_type_name = ''nfmd''
            AND (wb.remaining_stock_cnt > 0 OR :2 = 5)

          THEN
              INSERT (KJWO_WW, 
              MANDANT_ID, 
              AKTION_ID,
              ART_ID, 
              WUP_ID,
              DISCOUNT_TYPE_NAME,
              WRG_ID, 
              DWH_CREATED_TMSP, 
              USER_ID, 
              MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL, 
              MANUAL_PROMO_PRICE_DT, 
              LAST_TRANSFER_TMSP, 
              MODEL_PRICE_GROSS_LOCAL_VAL)
              VALUES (wb.KJWO_WW,
                      wb.MANDANT_ID,
                      wb.AKTION_ID,
                      wb.ART_ID,
                      wb.WUP_ID,
                      wb.DISCOUNT_TYPE_NAME,
                      wb.WRG_ID,
                      CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
                      :3,
                      wb.MANUAL_MARKDOWN_PRICE,
                      wb.valid_from,
                      (SELECT MAX(EXECUTION_TMSP) FROM DBP_VIEW.V_NFMD_PIPELINE_EXPORT_LOG_2 WHERE MANDANT_ID = :2),
                      SRC_MODEL_PRICE_GROSS_LOCAL_VAL)`;
var stmt = snowflake.createStatement({
      sqlText : sql_stmt, binds: [P_KJWO_WW,P_MANDANT_ID,P_USER_ID]});
stmt.execute();

var sql_stmt2 = `INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE_LOG_2 (KJWO_WW, MANDANT_ID, DWH_CREATED_TMSP, USER_ID)VALUES(:1, :2,  CURRENT_TIMESTAMP::TIMESTAMP_NTZ, :3)`;
var stmt2 = snowflake.createStatement({
      sqlText : sql_stmt2, binds: [P_KJWO_WW,P_MANDANT_ID,P_USER_ID]});
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
';