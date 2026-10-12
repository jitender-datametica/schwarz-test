CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_debitor_per
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  debitor_id AS debitor_id,
  debitor_status_id AS debitor_status_id,
  dat_von AS dat_von,
  dat_bis AS dat_bis,
  COALESCE(konzessionaer_id, '0') AS konzessionaer_id,
  ivs_fg AS ivs_fg
FROM kfl_production_dbp_view.v_ivs_debitor_per AS dp
WHERE
  dat_bis = CAST('9999-12-31' AS DATE) AND ivs_fg = 1;
