CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_zb_projekt_gewerk_vertrag_partner (mandant_id
OPTIONS(description='Mandant im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), vertrag_nr
OPTIONS(description='Nummer des Vertrages.'), partner_id OPTIONS(description='Geschäftspartnernummer'), anmerkung_txt
OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk, Warengruppe, Kostenart'),
nicht_relevant_fg
OPTIONS(description='Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).'))
OPTIONS(DESCRIPTION = `TS-Tabelle auf Ebene Projekt, Gewerk, Vertrag und Partner / Lieferant für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich einem Vertrag zuordnen lassen.`)
AS SELECT mandant_id,
 projekt_nr,
 gewerk_id,
 vertrag_nr,
 partner_id,
 anmerkung_txt,
 nicht_relevant_fg
FROM kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_vertrag_partner;