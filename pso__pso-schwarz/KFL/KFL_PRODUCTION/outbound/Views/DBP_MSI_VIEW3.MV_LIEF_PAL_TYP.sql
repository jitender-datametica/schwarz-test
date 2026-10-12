CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lief_pal_typ (lief_pal_typ_id, mandant_id, lief_pal_typ_grp_id,
lief_pal_typ_grp_dwh_id) AS (SELECT CAST(lief_pal_typ_id AS STRING) AS lief_pal_typ_id,
  mandant_id,
  CAST(CASE
    WHEN lief_pal_typ_id = '1' OR lief_pal_typ_id = '2'
    THEN 'OP'
    WHEN lief_pal_typ_id = '3'
    THEN 'DP'
    WHEN lief_pal_typ_id = '4' OR lief_pal_typ_id = '5'
    THEN 'MP'
    WHEN lief_pal_typ_id = '6' OR lief_pal_typ_id = '61' OR lief_pal_typ_id = '64'
    THEN 'MOGP'
    WHEN lief_pal_typ_id = '7'
    THEN 'BB'
    WHEN lief_pal_typ_id = '8'
    THEN 'AKA_MP'
    WHEN lief_pal_typ_id = '9'
    THEN 'KKP'
    WHEN lief_pal_typ_id = 'G'
    THEN 'MP'
    WHEN lief_pal_typ_id = 'F'
    THEN 'other'
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
    WHEN lief_pal_typ_id = '7'
    THEN 'BB'
    WHEN lief_pal_typ_id = '8'
    THEN 'AKA_MP'
    WHEN lief_pal_typ_id = '9'
    THEN 'KKP'
    WHEN lief_pal_typ_id = 'G'
    THEN 'MP'
    WHEN lief_pal_typ_id = 'F'
    THEN 'other'
    ELSE 'not assigned'
    END AS STRING) AS lief_pal_typ_grp_dwh_id
 FROM kfl_production_dbp_view.v_l_lief_pal_typ
 UNION DISTINCT
 SELECT '61' AS lief_pal_typ_id,
  mandant_id,
  'MOGP' AS lief_pal_typ_grp_id,
  'MO_OP' AS lief_pal_typ_grp_dwh_id
 FROM kfl_production_dbp_view.v_l_lief_pal_typ)
UNION DISTINCT
SELECT '64' AS lief_pal_typ_id,
 mandant_id,
 'MOGP' AS lief_pal_typ_grp_id,
 'MO_MP' AS lief_pal_typ_grp_dwh_id
FROM kfl_production_dbp_view.v_l_lief_pal_typ;