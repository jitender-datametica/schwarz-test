CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_buchungsstatus_ker (KJ_KER_MO_ID FLOAT, DAT_FI1 DATE, DAT_FI2 DATE, DAT_BS DATE)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.l_buchungsstatus_ker_1 SET dat_fruehinfo1= ?
, dat_fruehinfo2= ?
, dat_buchungs_schluss = ?
where kj_ker_mo_id = ?`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [DAT_FI1.toISOString(),DAT_FI2.toISOString(),DAT_BS.toISOString(),KJ_KER_MO_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

