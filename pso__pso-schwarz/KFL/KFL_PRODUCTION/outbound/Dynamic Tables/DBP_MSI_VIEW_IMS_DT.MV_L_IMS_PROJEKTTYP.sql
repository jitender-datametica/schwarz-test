CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_ims_projekttyp
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  ims_projekt_typ_id AS projekt_typ_id
FROM kfl_production_dbp_view.v_l_ims_projekt_typ AS v01;
