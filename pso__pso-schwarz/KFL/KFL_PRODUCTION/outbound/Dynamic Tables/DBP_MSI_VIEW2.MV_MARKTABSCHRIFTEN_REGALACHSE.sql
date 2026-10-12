CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_marktabschriften_regalachse
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.wup_id AS wup_id,
  v01.abschriftart_id AS abschriftenart_id,
  v01.nb_id AS nb_id,
  v01.dat AS dat,
  v01.woche_id AS woche_id,
  v01.art_id AS art_id,
  r.fbb_nr AS fbb_nr,
  r.fachboden_nr AS fachboden_nr,
  r.fachboden_pos AS fachboden_pos,
  CASE
    WHEN v01.abschriftbetrag_netto > 0
    THEN CAST(v01.abschriftbetrag_netto AS BIGNUMERIC) * r.kapazitaet_faktor
    ELSE NULL
  END AS abschriftenbetrag_netto
FROM kfl_production_dbp_view.v_marktabschriften AS v01
INNER JOIN kfl_production_dbp_view.v_regalachse_akt AS r
  ON v01.art_id = r.art_id
  AND v01.mandant_id = r.mandant_id
  AND v01.wup_id = r.wup_id
  AND v01.nb_id = r.nb_id
WHERE
  v01.mandant_id = 1;
