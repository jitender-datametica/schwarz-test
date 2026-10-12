CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_immo_altvertraege_map
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v1.mandant_id AS mandant_id,
  v1.mv_intreno AS mv_intreno,
  v2.mietvertrag_nr AS mietvertrag_nr,
  v1.melderegel AS melderegel,
  v1.version AS version,
  v1.kjmo AS kjmo,
  v1.rhythmus_art AS rhythmus_art,
  v1.dat_meldungsintervall_von AS dat_meldungsintervall_von,
  v1.dat_meldungsintervall_bis AS dat_meldungsintervall_bis,
  v1.wrg_id AS wrg_id,
  v1.umsatzkennung AS umsatzkennung,
  v1.nullumsatz AS nullumsatz,
  v1.umsatz_netto AS umsatz_netto,
  v1.umsatz_brutto AS umsatz_brutto,
  v1.erfasser AS erfasser,
  v1.dat_ersterfassung AS dat_ersterfassung,
  v1.dat_letzte_bearbeitung AS dat_letzte_bearbeitung
FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v1
INNER JOIN kfl_production_dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf AS v2
  ON v1.mv_intreno = v2.mv_intreno AND v1.mandant_id = v2.mandant_id
WHERE
  v1.rhythmus_art = '0001'
  AND v1.nullumsatz <> 'X'
  AND v1.version = (
    SELECT
      MAX(version)
    FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per AS v3
    WHERE
      v1.mv_intreno = mv_intreno AND v1.kjmo = kjmo AND v1.melderegel = melderegel
  );
