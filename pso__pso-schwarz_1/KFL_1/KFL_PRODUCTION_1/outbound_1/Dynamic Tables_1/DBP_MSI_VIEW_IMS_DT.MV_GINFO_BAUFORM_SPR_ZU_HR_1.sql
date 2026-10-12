CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_ginfo_bauform_spr_zu_hr_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.ginfo_bauform_id AS ginfo_bauform_id,
  COALESCE(ls.ginfo_bauform_bez, de.ginfo_bauform_bez) AS ginfo_bauform_bez
FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu_1 AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_ginfo_bauform_spr_zu_1
  WHERE
    spr_id = 65
) AS ls
  ON de.ginfo_bauform_id = ls.ginfo_bauform_id
WHERE
  de.spr_id = 22;
