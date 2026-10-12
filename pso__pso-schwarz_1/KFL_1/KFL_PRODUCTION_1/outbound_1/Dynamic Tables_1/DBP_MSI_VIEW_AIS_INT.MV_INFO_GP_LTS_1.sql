CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_info_gp_lts_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id,
  v01.gp_id,
  v03.gp_name_lat AS gp_name,
  v03.gp_name_lat AS gp_name_de,
  v03.gp_name_lat AS gp_name_cz,
  v03.gp_name_lat AS gp_name_pl,
  v03.gp_name_lat AS gp_name_md,
  v03.gp_name_lat AS gp_name_sk,
  v03.gp_name_lat AS gp_name_hr,
  v03.gp_name_lat AS gp_name_ro,
  v03.gp_name AS gp_name_bg,
  v01.gp_teilsortiment_id,
  v02.gp_teilsortiment_bez,
  v01.zek_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS v01
INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gp_id = v02.gp_id
  AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id
INNER JOIN kfl_production_dbp_view.v_gp_1 AS v03
  ON v01.mandant_id = v03.mandant_id AND v01.gp_id = v03.gp_id
WHERE
  v01.gp_id <> -1
UNION ALL
SELECT
  v01.mandant_id,
  v03.gp_id,
  v03.gp_name_lat AS gp_name,
  v03.gp_name_lat AS gp_name_de,
  v03.gp_name_lat AS gp_name_cz,
  v03.gp_name_lat AS gp_name_pl,
  v03.gp_name_lat AS gp_name_md,
  v03.gp_name_lat AS gp_name_sk,
  v03.gp_name_lat AS gp_name_hr,
  v03.gp_name_lat AS gp_name_ro,
  v03.gp_name AS gp_name_bg,
  v01.gp_teilsortiment_id,
  v02.gp_teilsortiment_bez,
  v01.zek_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS v01
INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gp_id = v02.gp_id
  AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id
INNER JOIN kfl_production_dbp_view.v_gp_1 AS v03
  ON v01.mandant_id = v03.mandant_id
WHERE
  v01.gp_id = -1;