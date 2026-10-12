CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v02.kl_art_id AS kl_art_id,
  COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A') AS art_bez,
  COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A') AS art_bez_de,
  COALESCE(
    MAX(CASE WHEN v01.spr_id = 124 THEN v01.art_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A')
  ) AS art_bez_cz,
  COALESCE(
    MAX(CASE WHEN v01.spr_id = 108 THEN v01.art_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A')
  ) AS art_bez_sk,
  COALESCE(
    MAX(CASE WHEN v01.spr_id = 65 THEN v01.art_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A')
  ) AS art_bez_hr,
  COALESCE(
    MAX(CASE WHEN v01.spr_id = 90 THEN v01.art_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A')
  ) AS art_bez_pl,
  COALESCE(
    MAX(CASE WHEN v01.spr_id = 95 THEN v01.art_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A')
  ) AS art_bez_ro,
  COALESCE(
    MAX(CASE WHEN v01.spr_id = 18 THEN v01.art_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.art_bez ELSE NULL END), 'N/A')
  ) AS art_bez_bg
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS v01
INNER JOIN kfl_production_dbp_view.v_art_2 AS v02
  ON v01.art_id = v02.art_id AND v01.mandant_id = v02.mandant_id
GROUP BY
  v01.mandant_id,
  v01.art_id,
  v02.kl_art_id;
