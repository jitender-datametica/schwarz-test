CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tdl_prompt (mandant_id, tdl_id, tdl_name_belos,
tdl_name_wanko, belos_fg, wanko_fg, tdl_name) AS SELECT mandant_id,
 tdl_id,
 MAX(CASE
   WHEN tdl_src = 'BELOS'
   THEN tdl_name
   ELSE NULL
   END) AS tdl_name_belos,
 MAX(CASE
   WHEN tdl_src = 'WANKO'
   THEN tdl_name
   ELSE NULL
   END) AS tdl_name_wanko,
 MAX(CASE
   WHEN tdl_src = 'BELOS'
   THEN 1
   ELSE 0
   END) AS belos_fg,
 MAX(CASE
   WHEN tdl_src = 'WANKO'
   THEN 1
   ELSE 0
   END) AS wanko_fg,
 COALESCE(MAX(CASE
    WHEN tdl_src = 'WANKO'
    THEN tdl_name
    ELSE NULL
    END), MAX(CASE
    WHEN tdl_src = 'BELOS'
    THEN tdl_name
    ELSE NULL
    END)) AS tdl_name
FROM (SELECT mandant_id,
    belos_adresse_id AS tdl_id,
    'BELOS' AS tdl_src,
    adress_name AS tdl_name
   FROM kfl_production_dbp_data.belos_adresse
   WHERE spedition_fg = 1
   UNION DISTINCT
   SELECT GP.mandant_id,
    GP.tms_gp_id AS tdl_id,
    'WANKO' AS tdl_src,
    GP.tms_gp_name AS tdl_name
   FROM kfl_production_dbp_data.tms_gp AS GP
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
          END)) = 1) AS v00
GROUP BY mandant_id,
 tdl_id;