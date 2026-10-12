CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_QUAL_MELDUNG_1
-- 26.10.2011 system_id entfernt
-- 11.05.2012 twie: dat_pruef_von in PARTITION BY aufgenommen, da die Anweisung sonst nicht deterministisch ist
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, qual_meldung_id
, meldungsart_id
, in_lief_id
, best_beleg_id
, zeit_pforte
, dat_erfasst
, min_dat_pruef_von
)
AS
   SELECT
   v01.mandant_id, v01.qual_meldung_id, v01.meldungsart_id, v01.flw_lief_id AS in_lief_id, v01.best_beleg_id, v01.zeit_pforte, v01.dat_erfasst, COALESCE(v02.dat_pruef_von, dat_erfasst) min_dat_pruef_von

   FROM dbp_view.v_flw_qual_meldung_1 v01
   LEFT OUTER JOIN

   -- Laut Anforderung Fachbereich ist gewuenscht, Qualitaetsmeldungen auf
   -- minimalen zugegoerigen dat_pruef_von (PRUEFDATUV) auszuwerten.
   -- Folgende Derived Table dient der Ermittlung minimaler dat_pruef_von
   -- pro Qualitaetsmeldung.

   ( SELECT  mandant_id, qual_meldung_id, min(dat_pruef_von) dat_pruef_von
   FROM

   ( SELECT  mandant_id, prueflos_id, qual_meldung_id, dat_pruef_von
   FROM dbp_view.v_flw_pruefmerkmal_ergebnis_1
   WHERE qual_meldung_id <> 0
   QUALIFY ROW_NUMBER() OVER  (PARTITION BY mandant_id, prueflos_id, dat_pruef_von
   ORDER BY qual_meldung_id asc)  = 1) v021
   GROUP BY  mandant_id, qual_meldung_id
   ) v02
   ON v01.mandant_id            = v02.mandant_id AND
   v01.qual_meldung_id   =  v02.qual_meldung_id;