CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mo_nutzung_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mo_nutzung_id AS mo_nutzung_id
FROM kfl_production_dbp_view.v_immo_l_mo_nutzung_2 AS v0
WHERE
  mandant_id = 1;
