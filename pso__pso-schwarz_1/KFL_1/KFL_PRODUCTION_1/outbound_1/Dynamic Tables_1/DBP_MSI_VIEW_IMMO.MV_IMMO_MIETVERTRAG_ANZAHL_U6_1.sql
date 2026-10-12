CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_anzahl_u6_1
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
  COUNT(DISTINCT kjmo) AS anzahl_umsaetze
FROM kfl_production_dbp_msi_view_immo.mv_immo_mietvertrag_umsatz_12_1 AS v1
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
