CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_flaeche_typ_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  ginfo_flaeche_typ_id AS ginfo_flaeche_typ_id,
  mandant_id AS mandant_id,
  ginfo_flaeche_typ_bez AS ginfo_flaeche_typ_bez
FROM kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu_2
WHERE
  spr_id = 22;
