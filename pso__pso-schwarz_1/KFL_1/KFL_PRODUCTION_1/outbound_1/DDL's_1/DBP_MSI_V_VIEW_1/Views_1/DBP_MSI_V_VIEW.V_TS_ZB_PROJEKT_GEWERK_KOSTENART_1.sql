CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_zb_projekt_gewerk_kostenart_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), buchung_typ_cd
OPTIONS(description='Code gibt an ob es sich um eine_1 Buchung zu einer Bestellung (B), eine_1 Buchung zum Vertrag (V) oder um eine_1 Buchung ohne Bestellung und Vertrag (O) handelt.'),
krk_id OPTIONS(description='globale ID des Kostenrechnungskreises'), kostenart_id
OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), anmerkung_txt
OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk,, Kostenart_1'), nicht_relevant_fg
OPTIONS(description='Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).'))
OPTIONS(DESCRIPTION = `TS-Tabelle auf Ebene Projekt, Gewerk und Kostenart_1  für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.`)
AS SELECT mandant_id,
 projekt_nr,
 gewerk_id,
 buchung_typ_cd,
 krk_id,
 kostenart_id,
 gp_id,
 anmerkung_txt,
 nicht_relevant_fg
FROM kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_kostenart_1;