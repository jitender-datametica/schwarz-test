CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tdl (mandant_id, tdl_id, tdl_src, tdl_name) AS SELECT
 mandant_id,
 belos_adresse_id AS tdl_id,
 'BELOS' AS tdl_src,
 adress_name AS tdl_name
FROM kfl_production_dbp_view.v_belos_adresse
WHERE spedition_fg = 1
UNION DISTINCT
SELECT GP.mandant_id,
 GP.tms_gp_id AS tdl_id,
 'WANKO' AS tdl_src,
 GP.tms_gp_name AS tdl_name
FROM kfl_production_dbp_view.v_tms_gp AS GP
 INNER JOIN kfl_production_dbp_view.v_l_system AS S ON GP.system_id = S.system_id
WHERE GP.tms_gp_typ_cd = 'S'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(GP.mandant_id AS STRING), GP.tms_gp_id ORDER BY CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END IS NULL, CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END)) = 1;