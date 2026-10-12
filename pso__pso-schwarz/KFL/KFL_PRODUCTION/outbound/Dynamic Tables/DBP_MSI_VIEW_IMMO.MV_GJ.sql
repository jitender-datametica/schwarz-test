CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_gj
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=60
) AS
SELECT
  gj AS gj,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett,
  SUBSTR(CAST(gj AS STRING), 1, 4) || '03' AS dat_gj_beginn,
  DATE_SUB(IF(
    DATE(SAFE_CAST(SUBSTR(CAST(gj AS STRING), 1, 4) || '03' AS STRING)) = LAST_DAY(DATE(SAFE_CAST(SUBSTR(CAST(gj AS STRING), 1, 4) || '03' AS STRING))),
    LAST_DAY(
      DATE_ADD(DATE(SAFE_CAST(SUBSTR(CAST(gj AS STRING), 1, 4) || '03' AS STRING)), INTERVAL '12' MONTH)
    ),
    DATE_ADD(DATE(SAFE_CAST(SUBSTR(CAST(gj AS STRING), 1, 4) || '03' AS STRING)), INTERVAL '12' MONTH)
  ), INTERVAL '1' DAY) AS dat_gj_ende
FROM kfl_production_dbp_view.v_jahr_gj
WHERE
  akt_gj BETWEEN -5 AND 1;
