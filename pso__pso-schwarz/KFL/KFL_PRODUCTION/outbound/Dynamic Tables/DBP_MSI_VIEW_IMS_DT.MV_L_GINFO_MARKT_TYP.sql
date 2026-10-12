CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_ginfo_markt_typ
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  ginfo_markt_typ AS ginfo_markt_typ,
  CASE WHEN ginfo_markt_typ = '' THEN '' ELSE ginfo_markt_typ_bez END AS ginfo_markt_typ_bez
FROM kfl_production_dbp_view.v_l_ginfo_markt_typ;
