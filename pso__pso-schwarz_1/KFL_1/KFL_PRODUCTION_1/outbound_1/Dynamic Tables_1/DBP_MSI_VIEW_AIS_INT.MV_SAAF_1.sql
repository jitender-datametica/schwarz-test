CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_saaf_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  bewart_id AS bewart_id,
  COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A') AS bewart_bez,
  COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A') AS bewart_bez_de,
  COALESCE(
    MAX(CASE WHEN spr_id = 124 THEN bewart_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A')
  ) AS bewart_bez_cz,
  COALESCE(
    MAX(CASE WHEN spr_id = 108 THEN bewart_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A')
  ) AS bewart_bez_sk,
  COALESCE(
    MAX(CASE WHEN spr_id = 65 THEN bewart_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A')
  ) AS bewart_bez_hr,
  COALESCE(
    MAX(CASE WHEN spr_id = 90 THEN bewart_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A')
  ) AS bewart_bez_pl,
  COALESCE(
    MAX(CASE WHEN spr_id = 95 THEN bewart_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A')
  ) AS bewart_bez_ro,
  COALESCE(
    MAX(CASE WHEN spr_id = 18 THEN bewart_bez ELSE NULL END),
    COALESCE(MAX(CASE WHEN spr_id = 22 THEN bewart_bez ELSE NULL END), 'N/A')
  ) AS bewart_bez_bg
FROM kfl_production_dbp_view.v_bewart_spr_zu_1 AS v01
WHERE
  bewart_id IN (1001, 1002, 1010)
GROUP BY
  mandant_id,
  bewart_id;
