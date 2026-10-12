CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_mass_typ_spr_zu_sk_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.in_massnahme_typ_id AS in_massnahme_typ_id,
  COALESCE(ls.in_massnahme_typ_bez, de.in_massnahme_typ_bez) AS in_massnahme_typ_bez
FROM kfl_production_dbp_view.v_in_mass_typ_spr_zu_2 AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_in_mass_typ_spr_zu_2
  WHERE
    spr_id = 108
) AS ls
  ON de.in_massnahme_typ_id = ls.in_massnahme_typ_id
WHERE
  de.spr_id = 22;
