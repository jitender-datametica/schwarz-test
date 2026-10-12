CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_preisklasse_wg_sortiment (S_WG_ID FLOAT, S_PL_1 FLOAT, S_PL_2 FLOAT, S_PL_3 FLOAT, S_PL_4 FLOAT, S_PL_5 FLOAT, S_PL_6 FLOAT, S_PL_7 FLOAT, S_PL_8 FLOAT, S_PL_9 FLOAT, S_PL_10 FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `UPDATE dbp_data.ts_sortiment_preisklasse_uwg SET  preislage_1   = ?,
preislage_2   = ?,
preislage_3   = ?,
preislage_4   = ?,
preislage_5   = ?,
preislage_6   = ?,
preislage_7   = ?,
preislage_8   = ?,
preislage_9   = ?,
preislage_10 = ?
FROM
(SELECT DISTINCT
v01.kl_wg_id,
v03.kl_uwg_id
FROM dbp_view.v_kl_wg_nielsen v01
JOIN dbp_view.v_kl_owg_nielsen v02
ON v01.kl_wg_id = v02.kl_wg_id
JOIN dbp_view.v_kl_uwg_nielsen v03
ON v03.kl_owg_id = v02.kl_owg_id
WHERE v01.kl_wg_id = ?
) AS src
WHERE dbp_data.ts_sortiment_preisklasse_uwg.kl_uwg_id = src.kl_uwg_id`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [S_PL_1,S_PL_2,S_PL_3,S_PL_4,S_PL_5,S_PL_6,S_PL_7,S_PL_8,S_PL_9,S_PL_10,S_WG_ID]
}).execute();
 var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

