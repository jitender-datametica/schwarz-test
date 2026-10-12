CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_projekt_abrg_dat_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.in_projekt_id AS in_projekt_id,
  MAX(v01.in_projekt_id_char) AS in_projekt_id_char,
  MAX(COALESCE(v02.dat_abschluss, CAST('9999-12-31' AS DATE))) AS dat_,
  CASE
    WHEN MAX(COALESCE(v02.dat_abschluss, CAST('9999-12-31' AS DATE))) = CAST('9999-12-31' AS DATE)
    THEN '2001'
    ELSE CAST(MAX(COALESCE(v02.dat_abschluss, CAST('9999-12-31' AS DATE))) AS STRING)
  END AS abrg_dat
FROM kfl_production_dbp_view.v_in_projekt AS v01
INNER JOIN kfl_production_dbp_view.v_in_psp_element AS v02
  ON v01.in_projekt_id = v02.in_projekt_id AND v01.mandant_id = v02.mandant_id
WHERE
  v02.statistisch_fg = 1
GROUP BY
  v01.mandant_id,
  v01.in_projekt_id;
