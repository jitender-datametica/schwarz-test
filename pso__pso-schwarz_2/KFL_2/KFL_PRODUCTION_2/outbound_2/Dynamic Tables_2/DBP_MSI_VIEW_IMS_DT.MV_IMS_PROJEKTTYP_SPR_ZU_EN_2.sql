CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ims_projekttyp_spr_zu_en_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  ims_projekt_typ_id AS projekt_typ_id,
  ims_projekt_typ_bez AS projekt_typ_bez
FROM kfl_production_dbp_view.v_ims_projekt_typ_spr_zu_2 AS v01
WHERE
  spr_id = 24;
