--==============================================================
-- Table: ts_wbs_ausliefergruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_ausliefergruppe
   generated from Powerdesigner on Montag, 19. Januar 2026 10:13:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_wbs_ausliefergruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
ausliefergruppe_id STRING(10) NOT NULL OPTIONS(description='Ausliefergruppe'),
berechnung_schwellwert_pal_abrundung_proz BIGNUMERIC(38,3)
OPTIONS(description='WBS Berechnung: Paletten Abrundung  Schwellwert in %'),
berechnung_schwellwert_pal_aufrundung_proz BIGNUMERIC(38,3)
OPTIONS(description='WBS Berechnung: Paletten Aufrundung  (nur im Nicht-Äderungsfall) in %'),
berechnung_kolli_rundung_proz BIGNUMERIC(38,3) OPTIONS(description='WBS Berechnung: Kolli Ab- und Aufrundung in %'),
nachversorgung_schwellwert_pal_abrundung_proz BIGNUMERIC(38,3)
OPTIONS(description='WBS Nachversorgung: Paletten Abrundung  Schwellwert in %'),
nachversorgung_schwellwert_pal_aufrundung_proz BIGNUMERIC(38,3)
OPTIONS(description='WBS Nachversorgung: Paletten Aufrundung  (nur im Nicht-Äderungsfall) in %'),
nachversorgung_kolli_rundung_proz BIGNUMERIC(38,3)
OPTIONS(description='WBS Nachversorgung: Kolli Ab- und Aufrundung in %'),
max_kapa_endbestand_proz BIGNUMERIC(38,3) OPTIONS(description='Max. Kapa für Endbestand in %'),
bestand_betrachtung_proz BIGNUMERIC(38,3) OPTIONS(description='Bestandbetrachtung in %'),
rest_von_normalbestand_proz BIGNUMERIC(38,3) OPTIONS(description='Restbestand in % vom Normalbestand'),
erweiterung_bedarfshorizont_tage BIGNUMERIC(38,0)
OPTIONS(description='Erweiterung des Bedarfshorizonts bei der Werbemengenhochrechnung in Tagen.            Bedarfshorizont = Demand-Horizont. Das ist ein Zeitraum, für welchen der Bedarf ermittelt wird ( die benötigte Menge für den Abverkauf)            Bei der Ermittlung der Menge muss immer prüfen, für wie viele Tage diese reichen muss'),
menge_zielendbestand_schwellwert_ame BIGNUMERIC(38,0)
OPTIONS(description='Schwellwert, ab welchem der Zielendbestand bei der Berechnung verwendet wird'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ausliefergruppe_id) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - This table contains settings for WBS calculation core on AUGR level (Auslieferungsgruppe). Content is maintained by transaction services document. Promotional weeks are added in advance and users can make changes to the settings, in which case the contents here are overwritten.');