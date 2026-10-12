CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_zb_projekt_gewerk_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), wrg_typ_id
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_zek
OPTIONS(description='Betrag der zu erwartenden Mehr- bzw. Minderkosten des Projektes auf Ebene Gewerk'), anmerkung_txt
OPTIONS(description='Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk.'))
OPTIONS(DESCRIPTION = `TS-Tabelle auf Ebene Projekt und Gewerk für zusätzliche Projektdaten aus den Zentralbereichen`)
AS SELECT mandant_id,
 projekt_nr,
 gewerk_id,
 wrg_typ_id,
 wrg_id,
 betrag_zek,
 anmerkung_txt
FROM kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_1;