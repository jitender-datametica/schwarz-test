CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_ist_kosten (mandant_id OPTIONS(description='Mandant im DWH'),
buchung_beleg_nr OPTIONS(description='Belegnummer der Buchung'), buchung_beleg_pos_nr
OPTIONS(description='Nummer der Belegposition / Buchungszeile der Buchung'), dat_buchung_beleg
OPTIONS(description='Datum der Buchung'), buchung_typ_cd
OPTIONS(description='Code gibt an ob es sich um eine Buchung zu einer Bestellung (B), eine Buchung zum Vertrag (V) oder um eine Buchung ohne Bestellung und Vertrag (O) handelt.'),
kosten_typ_cd
OPTIONS(description='Code gibt Art der Kosten- / Buchungsposition an: B = Baukostenzuschuss, F = Foerderung, R = Rueckstellung, K = normale Kosten.'),
projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '), gewerk_id
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), konto_nr
OPTIONS(description='Nummer des Kontos'), gegen_konto_nr OPTIONS(description='Nummer des Gegenkontos'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), material_nr
OPTIONS(description='Nummer des Materials.'), bestell_beleg_nr
OPTIONS(description='Handelt es sich um eine Buchung zu einer Bestellung, Belegnummer der Bestellung.'),
bestell_beleg_pos_nr
OPTIONS(description='Handelt es sich um eine Buchung zu einer Bestellung, Nummer der Belegposition der Bestellung.'),
krk_id OPTIONS(description='globale ID des Kostenrechnungskreises'), kostenart_id
OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'), mietvertrag_nr
OPTIONS(description='Hanelt es sich um den Buchung Typ V und die Buchung kann einem Vertrag zugeordnet werden, befindet sich hier der eindeutige Identfier des zugeordneten Vertrages.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_buchung
OPTIONS(description='Betrag der Buchung in Landeswährung.'), buchung_beleg_txt
OPTIONS(description='Freitext des Buchungsbeleges.'))
OPTIONS(DESCRIPTION = `Enthält alle Buchungen die für Immobilienprojekte relevant sind. Diese können entweder aus einer Bestellungen, aus Verträgen und Konditionen oder ohne Bezug zu diesen und nur mit einem referenzierten Konto veranlasst werden.`)
AS SELECT mandant_id,
 buchung_beleg_nr,
 buchung_beleg_pos_nr,
 dat_buchung_beleg,
 buchung_typ_cd,
 kosten_typ_cd,
 projekt_nr,
 gewerk_id,
 konto_nr,
 gegen_konto_nr,
 gp_id,
 material_nr,
 bestell_beleg_nr,
 bestell_beleg_pos_nr,
 krk_id,
 kostenart_id,
 mietvertrag_nr,
 wrg_id,
 betrag_buchung,
 buchung_beleg_txt
FROM kfl_production_dbp_data.zb_projekt_ist_kosten;