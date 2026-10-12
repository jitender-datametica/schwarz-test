CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_u6_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  mv_intreno AS mv_intreno,
  mietvertrag_nr AS mietvertrag_nr,
  wrg_id AS wrg_id,
  wrg_typ_id AS wrg_typ_id,
  MAX(kjmo) AS kjmo,
  SUM(interval_months) AS count_melderegel,
  CASE WHEN SUM(interval_months) > 5 THEN SUM(umsatz_netto) ELSE 0 END AS umsatz_netto_u6,
  CASE
    WHEN SUM(interval_months) > 5
    THEN SUM(umsatz_netto) * 12 / SUM(interval_months)
    ELSE 0
  END AS hochgrch_umsatz_u6,
  CASE
    WHEN SUM(interval_months) <> 0
    THEN SUM(umsatz_netto) / SUM(interval_months)
    ELSE 0
  END AS avg_umsatz_u6
FROM kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_12_2 AS v1
WHERE
  akt_mo BETWEEN -12 AND (
    -1
  ) AND umsatz_netto > 0
GROUP BY
  mandant_id,
  mv_intreno,
  mietvertrag_nr,
  wrg_id,
  wrg_typ_id;
