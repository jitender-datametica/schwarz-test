CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_branche_ivs
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id,
	branche_id,
	branche_bez,
	spr_id
FROM kfl_production_dbp_view.v_ivs_l_branche
WHERE
  spr_id = 22;