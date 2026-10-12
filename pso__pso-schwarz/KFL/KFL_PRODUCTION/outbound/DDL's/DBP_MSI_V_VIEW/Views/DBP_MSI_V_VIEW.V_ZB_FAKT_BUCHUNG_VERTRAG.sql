CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_zb_fakt_buchung_vertrag (mandant_id
OPTIONS(description='Mandant im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), vertrag_nr
OPTIONS(description='Nummer des Vertrages.'), partner_id OPTIONS(description='Geschäftspartnernummer'), wrg_typ_id
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_vertrag
OPTIONS(description='Betrag der Vertragswerte auf Ebene Projekt und Gewerk'), betrag_obligo
OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'), betrag_buchung
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk'))
OPTIONS(DESCRIPTION = `Faktentabelle für Buchungen die einem Vertrag zugeordnet werden können auf Ebene Projekt, Gewerk, Lieferant und Vertrag.`)
AS SELECT mandant_id,
 projekt_nr,
 gewerk_id,
 vertrag_nr,
 partner_id,
 wrg_typ_id,
 wrg_id,
 betrag_vertrag,
 betrag_obligo,
 betrag_buchung
FROM kfl_production_dbp_msi_data.zb_fakt_buchung_vertrag;