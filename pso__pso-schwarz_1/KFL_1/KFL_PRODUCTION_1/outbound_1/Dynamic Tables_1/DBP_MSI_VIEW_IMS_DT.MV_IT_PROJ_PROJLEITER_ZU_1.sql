CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_it_proj_projleiter_zu_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_projekt_id AS it_projekt_id,
  ma_id AS it_pl_id
FROM kfl_production_dbp_view.v_it_projekt_ma_zu_1 AS v01
WHERE
  mandant_id = 1 AND ma_funktion_id = 'CLPL';
