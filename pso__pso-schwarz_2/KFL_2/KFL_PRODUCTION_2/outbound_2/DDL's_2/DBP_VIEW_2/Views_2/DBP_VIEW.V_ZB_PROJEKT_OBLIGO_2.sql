CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_obligo_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
bestell_beleg_nr OPTIONS(description='Belegnummer der Bestellung auf die sich das Obligo bezieht.'),
bestell_beleg_pos_nr OPTIONS(description='Belegposition der Bestellung auf die sich das Obligo bezieht.'), dat_beleg
OPTIONS(description='Datum des Beleges für das Obligo.'), krk_id
OPTIONS(description='globale ID des Kostenrechnungskreises'), kostenart_id
OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_obligo
OPTIONS(description='Betrag des Obligo. Noch ausstehender Betrag zur Zahlung.'), loesch_fg
OPTIONS(description='Flag gibt an, ob Eintrag im Quellsystem wieder gelöscht wurde und nicht für das Reporting relevant ist.'))
OPTIONS(DESCRIPTION = `Enthält das Obligo für die Bestellpositionen einer Bestellung. Unter Obligo versteht man die noch offenen Verbindlichkeiten.`)
AS SELECT mandant_id,
 bestell_beleg_nr,
 bestell_beleg_pos_nr,
 dat_beleg,
 krk_id,
 kostenart_id,
 wrg_id,
 betrag_obligo,
 loesch_fg
FROM kfl_production_dbp_data.zb_projekt_obligo_2;