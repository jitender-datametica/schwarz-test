CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_wg_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wg_id AS wg_id,
  arthiertyp_id AS arthiertyp_id,
  abt_id AS abt_id,
  TRIM(CAST(wg_id AS STRING FORMAT '000')) AS wg_id_lang,
  owg_id AS owg_id,
  werbeteam_cd AS werbeteam_cd
FROM kfl_production_dbp_view.v_wg_per_1 AS v01
WHERE
  dat_bis = CAST('9999-12-31' AS DATE);
