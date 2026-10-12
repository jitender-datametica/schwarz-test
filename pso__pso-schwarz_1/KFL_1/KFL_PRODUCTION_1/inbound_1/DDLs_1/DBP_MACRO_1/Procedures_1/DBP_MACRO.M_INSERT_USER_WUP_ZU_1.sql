CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_user_wup_zu ()
   RETURNS STRING
   LANGUAGE JAVASCRIPT
   EXECUTE AS OWNER
   AS
   $$
 	var resultSetCounter = 0;
var tablelist = new Array;
var procname = `dbp_macro.m_insert_user_wup_zu_`;
var sql_command = `select current_session() || '_' || to_varchar(current_timestamp, 'yyyymmddhh24missss')`;
var stmt = snowflake.createStatement({
   sqlText : sql_command
});
var res = stmt.execute();
res.next();
var sessionid = procname + res.getColumnValue(1);
var setname = `SELECT
COUNT(*) AS "EINTRÄGE VORHER"
FROM dbp_msi_data.user_wup_zu_1`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : []
}).execute();
//Löschen der Ziel-Tabelle
var sql_stmt = `DELETE FROM dbp_msi_data.user_wup_zu_1`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : []
}).execute();
var sql_stmt = `INSERT INTO dbp_msi_data.user_wup_zu_1 (
user_id
, mandant_id
, wup_id)SELECT
v.user_id,
v.mandant_id,
v.wup_id
FROM
(SELECT
user_id,
hl_bm.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 hl_bm

INNER JOIN dbp_data.wup_1 w
ON LOWER(hl_bm.hierarchie_ebene_id) = 'hl_1'
AND hl_bm.hierarchie_element_id = w.wup_id
AND hl_bm.mandant_id =  w.mandant_id

UNION
SELECT
user_id,
vkl_bm.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 vkl_bm

INNER JOIN dbp_msi_data.wup_denorm_1 w
ON LOWER(vkl_bm.hierarchie_ebene_id) = 'vkl_1'
AND vkl_bm.hierarchie_element_id = w.vkl_id
AND vkl_bm.mandant_id =  w.mandant_id

UNION
SELECT
user_id,
vs_bm.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 vs_bm

INNER JOIN dbp_data.wup_1 w
ON LOWER(vs_bm.hierarchie_ebene_id) = 'vs_1'
AND vs_bm.hierarchie_element_id = w.vs_id
AND vs_bm.mandant_id =  w.mandant_id

UNION
SELECT
user_id,
gf_bm.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 gf_bm

INNER JOIN dbp_msi_data.wup_denorm_1 w
ON LOWER(gf_bm.hierarchie_ebene_id) = 'gf_1'
AND gf_bm.hierarchie_element_id = w.gf_gbl_vertrieb_id
AND gf_bm.mandant_id =  w.mandant_id

UNION
SELECT
user_id,
vst_bm.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 vst_bm

INNER JOIN dbp_data.wup_1 w
ON LOWER(vst_bm.hierarchie_ebene_id) = 'land_1'
AND vst_bm.hierarchie_element_id = w.mandant_id

UNION
SELECT
user_id,
w.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 vst_bm

CROSS JOIN dbp_data.wup_1 w
WHERE vst_bm.hierarchie_element_id = -1
AND LOWER(vst_bm.hierarchie_ebene_id) = 'land_1'

UNION
SELECT
user_id,
w.mandant_id,
wup_id
FROM dbp_msi_data.user_vis_benchmark_zu_1 vst_bm

CROSS JOIN dbp_data.wup_1 w
WHERE w.mandant_id <> 1
AND vst_bm.hierarchie_element_id = -2
AND LOWER(vst_bm.hierarchie_ebene_id) = 'land_1'
) v

INNER JOIN dbp_data.wup_1 w
ON v.mandant_id = w.mandant_id
AND v.wup_id = w.wup_id

WHERE w.dat_eroeffnung IS NOT NULL
AND TO_DATE((EXTRACT(YEAR FROM CURRENT_DATE)) - CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (1,2,3) THEN 3 ELSE 2 END || '-03-01', 'YYYY/MM_1/DD') <= w.dat_bis
AND w.nb_id IN (0, -1) -- Märkte und Zentralfilialen

GROUP BY 1,2,3`;
snowflake.createStatement({
   sqlText : sql_stmt,
   binds : []
}).execute();
var setname = `SELECT
COUNT(*) AS "EINTRÄGE NACHHER"
FROM dbp_msi_data.user_wup_zu_1`;
var tablename = sessionid + `_` + resultSetCounter++;
var sql_stmt = `CREATE TEMPORARY TABLE ${tablename} AS ${setname}`;
tablelist.push(tablename);
var RESULTSET = snowflake.createStatement({
   sqlText : sql_stmt,
   binds : []
}).execute();
return tablelist;
 
$$;

