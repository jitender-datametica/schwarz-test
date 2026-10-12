CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_wbs_ausliefergruppe_2 (mandant_id OPTIONS(description='Mandant_2'),
ausliefergruppe_id OPTIONS(description='Ausliefergruppe'), berechnung_schwellwert_pal_abrundung_proz
OPTIONS(description='WBS Berechnung: Paletten Abrundung Schwellwert in %'), berechnung_schwellwert_pal_aufrundung_proz
OPTIONS(description='WBS Berechnung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %'),
berechnung_kolli_rundung_proz OPTIONS(description='WBS Berechnung: Kolli Ab- und Aufrundung in %'),
nachversorgung_schwellwert_pal_abrundung_proz
OPTIONS(description='WBS Nachversorgung: Paletten Abrundung Schwellwert in %'),
nachversorgung_schwellwert_pal_aufrundung_proz
OPTIONS(description='WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %'),
nachversorgung_kolli_rundung_proz OPTIONS(description='WBS Nachversorgung: Kolli Ab- und Aufrundung in %'),
max_kapa_endbestand_proz OPTIONS(description='Max. Kapa für Endbestand in %'), bestand_betrachtung_proz
OPTIONS(description='Bestandbetrachtung in %'), rest_von_normalbestand_proz
OPTIONS(description='Restbestand in % vom Normalbestand'), erweiterung_bedarfshorizont_tage
OPTIONS(description='Erweiterung des Bedarfshorizonts bei der Werbemengenhochrechnung in Tagen.\nBedarfshorizont = Demand-Horizont. Das ist ein Zeitraum, für welchen der Bedarf ermittelt wird ( die benötigte Menge für den Abverkauf)\nBei der Ermittlung der Menge muss immer prüfen, für wie viele Tage diese reichen muss'),
menge_zielendbestand_schwellwert_ame
OPTIONS(description='Schwellwert, ab welchem der Zielendbestand bei der Berechnung verwendet wird'),
ausliefergruppe_cluster_name
OPTIONS(description='Höherstufige logistische Gruppierung (Cluster), die kleinteilige Ausliefergruppen nach Sortimentsart und Temperaturzone zusammenfasst.\nMögliche Werte:\nFood\nFrische\nNon Food\nUltra Frische\nTiko\nSonstiges'))
AS SELECT mandant_id,
 ausliefergruppe_id,
 berechnung_schwellwert_pal_abrundung_proz,
 berechnung_schwellwert_pal_aufrundung_proz,
 berechnung_kolli_rundung_proz,
 nachversorgung_schwellwert_pal_abrundung_proz,
 nachversorgung_schwellwert_pal_aufrundung_proz,
 nachversorgung_kolli_rundung_proz,
 max_kapa_endbestand_proz,
 bestand_betrachtung_proz,
 rest_von_normalbestand_proz,
 erweiterung_bedarfshorizont_tage,
 menge_zielendbestand_schwellwert_ame,
 ausliefergruppe_cluster_name
FROM kfl_production_dbp_data.ts_wbs_ausliefergruppe_2;