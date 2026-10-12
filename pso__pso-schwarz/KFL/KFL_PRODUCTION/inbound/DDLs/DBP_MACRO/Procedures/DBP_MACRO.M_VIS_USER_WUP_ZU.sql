CREATE OR REPLACE PROCEDURE dbp_macro.m_vis_user_wup_zu () 
  RETURNS STRING 
  LANGUAGE JAVASCRIPT 
  EXECUTE AS OWNER 
  AS 
  $$ 
// VERSION_2022_02_02  
var str_result = 'DONE' ;
// DELETE_TABLE
var sql_stmt = `DELETE FROM dbp_msi_data.user_wup_zu`;
snowflake.createStatement({
    sqlText : sql_stmt,
    binds : []
}).execute();
// INSERT_TABLE
var sql_stmt = `INSERT INTO dbp_msi_data.user_wup_zu (user_id, mandant_id, wup_id)
SELECT
  v.user_id
, v.mandant_id
, v.wup_id
FROM (
SELECT
  hl_bm.user_id
, hl_bm.mandant_id
, w.wup_id
FROM dbp_msi_data.user_vis_benchmark_zu hl_bm
INNER JOIN dbp_data.wup w
ON LOWER(hl_bm.hierarchie_ebene_id) = 'hl'
AND hl_bm.hierarchie_element_id = w.wup_id
AND hl_bm.mandant_id =  w.mandant_id
UNION
SELECT
  vkl_bm.user_id
, vkl_bm.mandant_id
, w.wup_id
FROM dbp_msi_data.user_vis_benchmark_zu vkl_bm
INNER JOIN dbp_msi_data.wup_denorm w
ON LOWER(vkl_bm.hierarchie_ebene_id) = 'vkl'
AND vkl_bm.hierarchie_element_id = w.vkl_id
AND vkl_bm.mandant_id =  w.mandant_id
UNION
SELECT
  gf_bm.user_id
, gf_bm.mandant_id
, w.wup_id
FROM dbp_msi_data.user_vis_benchmark_zu gf_bm
INNER JOIN dbp_msi_data.wup_denorm w
ON LOWER(gf_bm.hierarchie_ebene_id) = 'gf'
AND gf_bm.hierarchie_element_id = w.gf_gbl_vertrieb_id
AND gf_bm.mandant_id =  w.mandant_id
UNION
SELECT
  vs_bm.user_id
, vs_bm.mandant_id
, w.wup_id
FROM dbp_msi_data.user_vis_benchmark_zu vs_bm
INNER JOIN dbp_data.wup w
ON LOWER(vs_bm.hierarchie_ebene_id) = 'vs'
AND vs_bm.hierarchie_element_id = w.vs_id
AND vs_bm.mandant_id =  w.mandant_id
UNION
SELECT
  nat_bm.user_id
, nat_bm.mandant_id
, w.wup_id
FROM dbp_msi_data.user_vis_benchmark_zu nat_bm
INNER JOIN dbp_data.wup w
ON LOWER(nat_bm.hierarchie_ebene_id) = 'land'
AND nat_bm.hierarchie_element_id = w.mandant_id
) v 
INNER JOIN dbp_data.wup w
ON v.mandant_id = w.mandant_id
AND v.wup_id = w.wup_id
WHERE w.dat_eroeffnung IS NOT NULL 
AND w.dat_von IS NOT NULL 
AND TO_DATE((EXTRACT(YEAR FROM CURRENT_DATE)) - CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (1,2,3) THEN 3 ELSE 2 END || '-03-01') <= w.dat_bis
AND w.nb_id IN (0, -1) 
GROUP BY
  v.user_id
, v.mandant_id
, v.wup_id`;
snowflake.createStatement({
    sqlText : sql_stmt,
    binds : []
}).execute();

return str_result;

$$;