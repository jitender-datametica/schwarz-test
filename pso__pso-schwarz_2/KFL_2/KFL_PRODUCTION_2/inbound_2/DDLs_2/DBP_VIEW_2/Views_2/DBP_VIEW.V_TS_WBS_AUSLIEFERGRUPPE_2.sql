create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TS_WBS_AUSLIEFERGRUPPE_2(
	MANDANT_ID COMMENT 'Mandant_2',
	AUSLIEFERGRUPPE_ID COMMENT 'Ausliefergruppe',
	BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ COMMENT 'WBS Berechnung: Paletten Abrundung Schwellwert in %',
	BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ COMMENT 'WBS Berechnung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %',
	BERECHNUNG_KOLLI_RUNDUNG_PROZ COMMENT 'WBS Berechnung: Kolli Ab- und Aufrundung in %',
	NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ COMMENT 'WBS Nachversorgung: Paletten Abrundung Schwellwert in %',
	NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ COMMENT 'WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %',
	NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ COMMENT 'WBS Nachversorgung: Kolli Ab- und Aufrundung in %',
	MAX_KAPA_ENDBESTAND_PROZ COMMENT 'Max. Kapa für Endbestand in %',
	BESTAND_BETRACHTUNG_PROZ COMMENT 'Bestandbetrachtung in %',
	REST_VON_NORMALBESTAND_PROZ COMMENT 'Restbestand in % vom Normalbestand',
	ERWEITERUNG_BEDARFSHORIZONT_TAGE COMMENT 'Erweiterung des Bedarfshorizonts bei der Werbemengenhochrechnung in Tagen.\nBedarfshorizont = Demand-Horizont. Das ist ein Zeitraum, für welchen der Bedarf ermittelt wird ( die benötigte Menge für den Abverkauf)\nBei der Ermittlung der Menge muss immer prüfen, für wie viele Tage diese reichen muss',
	MENGE_ZIELENDBESTAND_SCHWELLWERT_AME COMMENT 'Schwellwert, ab welchem der Zielendbestand bei der Berechnung verwendet wird',
	AUSLIEFERGRUPPE_CLUSTER_NAME COMMENT 'Höherstufige logistische Gruppierung (Cluster), die kleinteilige Ausliefergruppen nach Sortimentsart und Temperaturzone zusammenfasst.\nMögliche Werte:\nFood\nFrische\nNon Food\nUltra Frische\nTiko\nSonstiges'
) as 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.TS_WBS_AUSLIEFERGRUPPE_2 ;
