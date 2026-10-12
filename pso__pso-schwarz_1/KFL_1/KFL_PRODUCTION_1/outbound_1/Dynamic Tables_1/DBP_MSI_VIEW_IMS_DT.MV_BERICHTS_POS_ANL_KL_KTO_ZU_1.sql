CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_anl_kl_kto_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  'AKL:' || anlage_klasse_id AS anl_kl_kto_id,
  berichts_position_invest_id AS berichts_position_invest_id,
  berichts_position_it_id AS berichts_position_it_id
FROM kfl_production_dbp_msi_v_view.v_berichts_pos_anl_kls_zu_per_1
WHERE
  dat_bis = CAST('9999-12-31' AS DATE)
UNION DISTINCT
SELECT
  'KTO:' || kostenart_id AS anl_kl_kto_id,
  berichts_position_invest_id,
  berichts_position_it_id
FROM kfl_production_dbp_msi_v_view.v_berichts_pos_kostart_zu_per_1
WHERE
  dat_bis = CAST('9999-12-31' AS DATE);
