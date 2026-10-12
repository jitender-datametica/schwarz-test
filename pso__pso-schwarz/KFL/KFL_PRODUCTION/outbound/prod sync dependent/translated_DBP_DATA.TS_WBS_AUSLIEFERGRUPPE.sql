CREATE OR REPLACE TABLE kfl_production_dbp_data.ts_wbs_ausliefergruppe (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant'),
ausliefergruppe_id STRING(10) NOT NULL OPTIONS(description='Ausliefergruppe'),
berechnung_schwellwert_pal_abrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Berechnung: Paletten Abrundung Schwellwert in %'),
berechnung_schwellwert_pal_aufrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Berechnung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %'),
berechnung_kolli_rundung_proz NUMERIC(29,3) OPTIONS(description='WBS Berechnung: Kolli Ab- und Aufrundung in %'),
nachversorgung_schwellwert_pal_abrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Nachversorgung: Paletten Abrundung Schwellwert in %'),
nachversorgung_schwellwert_pal_aufrundung_proz NUMERIC(29,3)
OPTIONS(description='WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %'),
nachversorgung_kolli_rundung_proz NUMERIC(29,3) OPTIONS(description='WBS Nachversorgung: Kolli Ab- und Aufrundung in %'),
max_kapa_endbestand_proz NUMERIC(29,3) OPTIONS(description='Max. Kapa für Endbestand in %'),
bestand_betrachtung_proz NUMERIC(29,3) OPTIONS(description='Bestandbetrachtung in %'),
rest_von_normalbestand_proz NUMERIC(29,3) OPTIONS(description='Restbestand in % vom Normalbestand'),
erweiterung_bedarfshorizont_tage INTEGER
OPTIONS(description='Erweiterung des Bedarfshorizonts bei der Werbemengenhochrechnung in Tagen.\n            Bedarfshorizont = Demand-Horizont. Das ist ein Zeitraum, für welchen der Bedarf ermittelt wird ( die benötigte Menge für den Abverkauf)\n            Bei der Ermittlung der Menge muss immer prüfen, für wie viele Tage diese reichen muss'),
menge_zielendbestand_schwellwert_ame INTEGER
OPTIONS(description='Schwellwert, ab welchem der Zielendbestand bei der Berechnung verwendet wird'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ausliefergruppe_cluster_name STRING(100)
OPTIONS(description='Höherstufige logistische Gruppierung (Cluster), die kleinteilige Ausliefergruppen nach Sortimentsart und Temperaturzone zusammenfasst.\n            Mögliche Werte:\n            Food\n            Frische\n            Non Food\n            Ultra Frische\n            Tiko\n            Sonstiges'),
PRIMARY KEY (mandant_id, ausliefergruppe_id) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - This table contains settings for WBS calculation core on AUGR level (Auslieferungsgruppe). Content is maintained by transaction services document. Promotional weeks are added in advance and users can make changes to the settings, in which case the contents here are overwritten.');