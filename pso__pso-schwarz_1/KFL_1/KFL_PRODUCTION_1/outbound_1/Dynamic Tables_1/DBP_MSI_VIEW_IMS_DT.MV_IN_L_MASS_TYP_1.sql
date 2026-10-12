CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_l_mass_typ_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  in_massnahme_typ_id AS in_massnahme_typ_id
FROM kfl_production_dbp_view.v_in_l_mass_typ_1;
