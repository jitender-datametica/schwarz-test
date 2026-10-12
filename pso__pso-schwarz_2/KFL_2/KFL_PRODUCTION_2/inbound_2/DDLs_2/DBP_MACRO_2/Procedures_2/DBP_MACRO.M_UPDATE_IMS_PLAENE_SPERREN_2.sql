CREATE OR REPLACE PROCEDURE dbp_macro.m_update_ims_plaene_sperren (GJ FLOAT, MANDANT_ID FLOAT, SPERR_FG FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE DBP_DATA.IMS_INVEST_PLAN_2 
                    SET  sperr_fg = ?
                   WHERE mandant_id = ?
                     AND gj = ?
                     AND hr_plan_gesamt_kz = 0`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [SPERR_FG,MANDANT_ID,GJ]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$
   ;