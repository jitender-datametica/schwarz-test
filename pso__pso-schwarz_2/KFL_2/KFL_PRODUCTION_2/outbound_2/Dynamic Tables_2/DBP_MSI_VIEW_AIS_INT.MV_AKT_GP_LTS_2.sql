CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_akt_gp_lts_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id,
  v01.gp_id as akt_gp_id,
  v03.gp_name_lat AS akt_gp_name,
  v03.gp_name_lat AS akt_gp_name_de,
  v03.gp_name_lat AS akt_gp_name_cz,
  v03.gp_name_lat AS akt_gp_name_pl,
  v03.gp_name_lat AS akt_gp_name_md,
  v03.gp_name_lat AS akt_gp_name_sk,
  v03.gp_name_lat AS akt_gp_name_hr,
  v03.gp_name_lat AS akt_gp_name_ro,
  v03.gp_name AS akt_gp_name_bg,
  v01.gp_teilsortiment_id,
  COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A') AS gp_teilsortiment_bez,
  COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A') AS gp_teilsortiment_bez_de,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 124 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_cz,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 108 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_sk,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 65 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_hr,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 90 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_pl,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 95 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_ro,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 18 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_bg
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_2 AS v01
INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_2 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gp_id = v02.gp_id
  AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id
INNER JOIN kfl_production_dbp_view.v_gp_2 AS v03
  ON v01.mandant_id = v03.mandant_id AND v01.gp_id = v03.gp_id
WHERE
  v01.gp_id <> -1
GROUP BY
  v01.mandant_id,
  v01.gp_id,
  akt_gp_name,
  akt_gp_name_de,
  akt_gp_name_cz,
  akt_gp_name_pl,
  akt_gp_name_md,
  akt_gp_name_sk,
  akt_gp_name_hr,
  akt_gp_name_ro,
  akt_gp_name_bg,
  v01.gp_teilsortiment_id
UNION ALL
SELECT
  v01.mandant_id,
  v03.gp_id,
  v03.gp_name_lat AS akt_gp_name,
  v03.gp_name_lat AS akt_gp_name_de,
  v03.gp_name_lat AS akt_gp_name_cz,
  v03.gp_name_lat AS akt_gp_name_pl,
  v03.gp_name_lat AS akt_gp_name_md,
  v03.gp_name_lat AS akt_gp_name_sk,
  v03.gp_name_lat AS akt_gp_name_hr,
  v03.gp_name_lat AS akt_gp_name_ro,
  v03.gp_name AS akt_gp_name_bg,
  v01.gp_teilsortiment_id,
  COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A') AS gp_teilsortiment_bez,
  COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A') AS gp_teilsortiment_bez_de,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 124 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_cz,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 108 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_sk,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 65 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_hr,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 90 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_pl,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 95 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_ro,
  COALESCE(
    MAX(CASE WHEN v02.spr_id = 18 THEN v02.gp_teilsortiment_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v02.spr_id = 22 THEN v02.gp_teilsortiment_bez ELSE NULL END), 'N/A')
  ) AS gp_teilsortiment_bez_bg
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_2 AS v01
INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_2 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gp_id = v02.gp_id
  AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id
INNER JOIN kfl_production_dbp_view.v_gp_2 AS v03
  ON v01.mandant_id = v03.mandant_id
WHERE
  v01.gp_id = -1
GROUP BY
  v01.mandant_id,
  v03.gp_id,
  akt_gp_name,
  akt_gp_name_de,
  akt_gp_name_cz,
  akt_gp_name_pl,
  akt_gp_name_md,
  akt_gp_name_sk,
  akt_gp_name_hr,
  akt_gp_name_ro,
  akt_gp_name_bg,
  v01.gp_teilsortiment_id;