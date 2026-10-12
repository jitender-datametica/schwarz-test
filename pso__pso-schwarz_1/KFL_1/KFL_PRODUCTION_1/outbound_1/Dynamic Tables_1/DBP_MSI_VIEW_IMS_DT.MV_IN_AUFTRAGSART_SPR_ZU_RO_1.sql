CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_auftragsart_spr_zu_ro_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.auftragsart_id AS auftragsart_id,
  COALESCE(ls.auftragsart_bez, de.auftragsart_bez) AS auftragsart_bez
FROM kfl_production_dbp_view.v_in_auftragsart_spr_zu_1 AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_in_auftragsart_spr_zu_1
  WHERE
    spr_id = 95
  QUALIFY
    (
      RANK() OVER (PARTITION BY auftragsart_id ORDER BY mandant_id IS NULL, mandant_id)
    ) = 1
) AS ls
  ON de.auftragsart_id = ls.auftragsart_id
WHERE
  de.spr_id = 22
QUALIFY
  (
    RANK() OVER (PARTITION BY de.auftragsart_id ORDER BY de.mandant_id IS NULL, de.mandant_id)
  ) = 1;
