-- 11.05.2012 twie: dat_pruef_von in PARTITION BY aufgenommen, da die Anweisung sonst nicht deterministisch ist

-- 26.10.2011 system_id entfernt
 -- , system_id
 -- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_qual_meldung_1 (mandant_id, qual_meldung_id,
meldungsart_id, in_lief_id, best_beleg_id, zeit_pforte, dat_erfasst, min_dat_pruef_von) AS
-- Laut Anforderung Fachbereich ist gewuenscht, Qualitaetsmeldungen auf

-- minimalen zugegoerigen dat_pruef_von (PRUEFDATUV) auszuwerten.

-- Folgende Derived Table dient der Ermittlung minimaler dat_pruef_von
 -- pro Qualitaetsmeldung.
 SELECT V01.mandant_id
 ,
 V01.qual_meldung_id,
 V01.meldungsart_id,
 V01.flw_lief_id AS in_lief_id,
 V01.best_beleg_id,
 V01.zeit_pforte,
 V01.dat_erfasst,
 COALESCE(v02.dat_pruef_von, V01.dat_erfasst) AS min_dat_pruef_von
FROM kfl_production_dbp_view.v_flw_qual_meldung_1 AS V01
 LEFT JOIN (SELECT mandant_id,
   qual_meldung_id,
   MIN(dat_pruef_von) AS dat_pruef_von
  FROM (SELECT *
    FROM kfl_production_dbp_view.v_flw_pruefmerkmal_ergebnis_1
    WHERE qual_meldung_id <> 0
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), prueflos_id, dat_pruef_von ORDER BY
          qual_meldung_id IS NULL, qual_meldung_id)) = 1) AS t0
  GROUP BY mandant_id,
   qual_meldung_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.qual_meldung_id = v02.qual_meldung_id;