CREATE OR REPLACE PROCEDURE dbp_macro.m_upd_preisklasse_wg_sortiment_ek_sort (S_MANDANT_ID FLOAT, S_OWG_ID FLOAT, S_WRG_ID CHAR(3), S_PL_1 FLOAT, S_PL_2 FLOAT, S_PL_3 FLOAT, S_PL_4 FLOAT, S_PL_5 FLOAT, S_PL_6 FLOAT, S_PL_7 FLOAT, S_PL_8 FLOAT, S_PL_9 FLOAT, S_PL_10 FLOAT)
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var sql_stmt = `MERGE INTO DBP_DATA.TS_SORTIMENT_PREISKLASSE_WUG AS t01 USING (SELECT DISTINCT
v01.mandant_id,
v01.default_wrg AS wrg_id,
v02.wg_id,
v03.wug_id
FROM dbp_msi_view_ek_sort.mv_mandant v01
JOIN dbp_msi_view_ek_sort.mv_wg_per v02
ON (v01.mandant_id = v02.mandant_id)
JOIN dbp_msi_view_ek_sort.mv_wug v03
ON (v02.mandant_id = v03.mandant_id AND  v02.wg_id = v03.wg_id)
WHERE  v01.mandant_id = ? AND v01.default_wrg = ? AND v02.owg_id = ?
) AS s01 ON ( t01.mandant_id = s01.mandant_id AND t01.wrg_id = s01.wrg_id AND t01.arthiertyp_id = 0 AND t01.wg_id = s01.wg_id AND t01.wug_id = s01.wug_id )
WHEN MATCHED THEN
UPDATE SET
preislage_1   = ?,
preislage_2   = ?,
preislage_3   = ?,
preislage_4   = ?,
preislage_5   = ?,
preislage_6   = ?,
preislage_7   = ?,
preislage_8   = ?,
preislage_9   = ?,
preislage_10 = ?
WHEN NOT MATCHED THEN
INSERT (MANDANT_ID,ARTHIERTYP_ID,WG_ID,WUG_ID,WRG_ID,PREISLAGE_1,PREISLAGE_2,PREISLAGE_3,PREISLAGE_4,PREISLAGE_5,PREISLAGE_6,PREISLAGE_7,PREISLAGE_8,PREISLAGE_9,PREISLAGE_10)
VALUES (
?,
0,
s01.wg_id,
s01.wug_id,
s01.wrg_id,
?,
?,
?,
?,
?,
?,
?,
?,
?,
?)`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : [S_MANDANT_ID,S_WRG_ID,S_OWG_ID,S_PL_1,S_PL_2,S_PL_3,S_PL_4,S_PL_5,S_PL_6,S_PL_7,S_PL_8,S_PL_9,S_PL_10,S_MANDANT_ID,S_PL_1,S_PL_2,S_PL_3,S_PL_4,S_PL_5,S_PL_6,S_PL_7,S_PL_8,S_PL_9,S_PL_10]
}).execute();
 
var sql_commit = `COMMIT;`
   snowflake.createStatement({
	   sqlText : sql_commit
	}).execute();

$$;

