CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_kondition_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
kondition_nr OPTIONS(description='Nummer der Kondition'), konditionstyp_id
OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'), projekt_nr
OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '), gewerk_id
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), mv_intreno
OPTIONS(description='Interner Schlüssel des Mietvertrages'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), partner_id
OPTIONS(description='Geschäftspartnernummer'), wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_kondition OPTIONS(description='Betrag der Kondition'))
OPTIONS(DESCRIPTION = `Enthält Konditionen zu Verträgen die für ein Projekt gültig sind.`) AS SELECT mandant_id,
 kondition_nr,
 konditionstyp_id,
 projekt_nr,
 gewerk_id,
 mv_intreno,
 gp_id,
 partner_id,
 wrg_id,
 betrag_kondition
FROM kfl_production_dbp_data.zb_projekt_kondition_1;