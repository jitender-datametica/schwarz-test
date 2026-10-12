CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_l_auftragsart
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  auftragsart_id AS auftragsart_id
FROM kfl_production_dbp_view.v_in_l_auftragsart
GROUP BY
  auftragsart_id;
