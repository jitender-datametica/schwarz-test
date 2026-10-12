CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_it_projekt_plan_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  plan_revision_id AS plan_version_id,
  it_projekt_id AS it_projekt_id,
  sonstiger_aufwand AS sonstiger_aufwand,
  aktivierungsquote_intern_plan AS aktivierungsquote_intern,
  aktivierungsquote_extern_plan AS aktivierungsquote_extern,
  dat_von AS dat_von,
  dat_bis AS dat_bis
FROM kfl_production_dbp_view.v_it_projekt_plan_1;
