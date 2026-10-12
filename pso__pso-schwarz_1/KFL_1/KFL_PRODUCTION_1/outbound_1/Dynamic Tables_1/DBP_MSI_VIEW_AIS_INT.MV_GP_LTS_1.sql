CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_gp_lts_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.gp_id AS gp_id,
  v03.gp_name_lat AS gp_name,
  v03.gp_name_lat AS gp_name_de,
  v03.gp_name_lat AS gp_name_cz,
  v03.gp_name_lat AS gp_name_pl,
  v03.gp_name_lat AS gp_name_md,
  v03.gp_name_lat AS gp_name_sk,
  v03.gp_name_lat AS gp_name_hr,
  v03.gp_name_lat AS gp_name_ro,
  v03.gp_name_lat AS gp_name_bg,
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
  ) AS gp_teilsortiment_bez_bg,
  v01.zek_id AS zek_id,
  v01.zahlungsziel_id AS zahlungsziel_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS v01
INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gp_id = v02.gp_id
  AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id
INNER JOIN kfl_production_dbp_view.v_gp_1 AS v03
  ON v01.mandant_id = v03.mandant_id AND v01.gp_id = v03.gp_id
WHERE
  v01.gp_id <> -1
GROUP BY
  v01.mandant_id,
  v01.gp_id,
  gp_name,
  gp_name_de,
  gp_name_cz,
  gp_name_pl,
  gp_name_md,
  gp_name_sk,
  gp_name_hr,
  gp_name_ro,
  gp_name_bg,
  v01.gp_teilsortiment_id,
  v01.zek_id,
  v01.zahlungsziel_id
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
  v03.gp_name_lat AS gp_name_bg,
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
  ) AS gp_teilsortiment_bez_bg,
  v01.zek_id,
  v01.zahlungsziel_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS v01
INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.gp_id = v02.gp_id
  AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id
INNER JOIN kfl_production_dbp_view.v_gp_1 AS v03
  ON v01.mandant_id = v03.mandant_id
WHERE
  v01.gp_id = -1
GROUP BY
  v01.mandant_id,
  v03.gp_id,
  gp_name,
  gp_name_de,
  gp_name_cz,
  gp_name_pl,
  gp_name_md,
  gp_name_sk,
  gp_name_hr,
  gp_name_ro,
  gp_name_bg,
  v01.gp_teilsortiment_id,
  v01.zek_id,
  v01.zahlungsziel_id;