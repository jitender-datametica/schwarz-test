CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_flaeche_typ_spr_zu_bg_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.ginfo_flaeche_typ_id AS ginfo_flaeche_typ_id,
  de.mandant_id AS mandant_id,
  COALESCE(ls.ginfo_flaeche_typ_bez, de.ginfo_flaeche_typ_bez) AS ginfo_flaeche_typ_bez
FROM kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu_1 AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu_1
  WHERE
    spr_id = 18
) AS ls
  ON de.ginfo_flaeche_typ_id = ls.ginfo_flaeche_typ_id
  AND de.mandant_id = ls.mandant_id
WHERE
  de.spr_id = 22;
