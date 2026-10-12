CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lief_pal_typ_2 AS ((((SELECT lief_pal_typ_id,
     CAST(CASE
       WHEN lief_pal_typ_id = '1' OR lief_pal_typ_id = '2'
       THEN 'OP'
       WHEN lief_pal_typ_id = '3'
       THEN 'DP'
       WHEN lief_pal_typ_id = '4' OR lief_pal_typ_id = '5'
       THEN 'MP'
       WHEN lief_pal_typ_id = '6' OR lief_pal_typ_id = '61' OR lief_pal_typ_id = '64'
       THEN 'MOGP'
       WHEN lief_pal_typ_id = 'J'
       THEN 'AKAF'
       WHEN lief_pal_typ_id = 'J4'
       THEN 'AKAF_MP'
       WHEN lief_pal_typ_id = 'J9'
       THEN 'AKAF_KKP'
       WHEN lief_pal_typ_id = '7'
       THEN 'BB'
       WHEN lief_pal_typ_id = '8'
       THEN 'AKA_MP'
       WHEN lief_pal_typ_id = '9'
       THEN 'KKP'
       WHEN lief_pal_typ_id = 'F'
       THEN 'other'
       WHEN lief_pal_typ_id = 'G'
       THEN 'MP'
       ELSE 'not assigned'
       END AS STRING) AS lief_pal_typ_grp_id,
     CAST(CASE
       WHEN lief_pal_typ_id = '1' OR lief_pal_typ_id = '2'
       THEN 'OP'
       WHEN lief_pal_typ_id = '3'
       THEN 'DP'
       WHEN lief_pal_typ_id = '4' OR lief_pal_typ_id = '5'
       THEN 'MP'
       WHEN lief_pal_typ_id = '6'
       THEN 'MOGP'
       WHEN lief_pal_typ_id = '61'
       THEN 'MO_OP'
       WHEN lief_pal_typ_id = '64'
       THEN 'MO_MP'
       WHEN lief_pal_typ_id = 'J'
       THEN 'AKAF'
       WHEN lief_pal_typ_id = 'J4'
       THEN 'AKAF_MP'
       WHEN lief_pal_typ_id = 'J9'
       THEN 'AKAF_KKP'
       WHEN lief_pal_typ_id = '7'
       THEN 'BB'
       WHEN lief_pal_typ_id = '8'
       THEN 'AKA_MP'
       WHEN lief_pal_typ_id = '9'
       THEN 'KKP'
       WHEN lief_pal_typ_id = 'F'
       THEN 'other'
       WHEN lief_pal_typ_id = 'G'
       THEN 'MP'
       ELSE 'not assigned'
       END AS STRING) AS lief_pal_typ_grp_dwh_id
    FROM kfl_production_dbp_view.v_l_lief_pal_typ_2
    UNION DISTINCT
    SELECT 'J4' AS lief_pal_typ_id,
     'AKAF_MP' AS lief_pal_typ_grp_id,
     'AKAF_MP' AS lief_pal_typ_grp_dwh_id
    FROM kfl_production_dbp_view.v_l_lief_pal_typ_2)
   UNION DISTINCT
   SELECT 'J9' AS lief_pal_typ_id,
    'AKAF_KKP' AS lief_pal_typ_grp_id,
    'AKAF_KKP' AS lief_pal_typ_grp_dwh_id
   FROM kfl_production_dbp_view.v_l_lief_pal_typ_2)
  UNION DISTINCT
  SELECT '61' AS lief_pal_typ_id,
   'MOGP' AS lief_pal_typ_grp_id,
   'MO_OP' AS lief_pal_typ_grp_dwh_id
  FROM kfl_production_dbp_view.v_l_lief_pal_typ_2)
 UNION DISTINCT
 SELECT '64' AS lief_pal_typ_id,
  'MOGP' AS lief_pal_typ_grp_id,
  'MO_MP' AS lief_pal_typ_grp_dwh_id
 FROM kfl_production_dbp_view.v_l_lief_pal_typ_2)
UNION DISTINCT
SELECT '' AS lief_pal_typ_id,
 '' AS lief_pal_typ_grp_id,
 '' AS lief_pal_typ_grp_dwh_id
FROM kfl_production_dbp_view.v_l_lief_pal_typ_2;