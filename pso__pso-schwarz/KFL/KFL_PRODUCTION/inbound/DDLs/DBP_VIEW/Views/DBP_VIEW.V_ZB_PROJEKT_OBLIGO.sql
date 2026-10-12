create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_OBLIGO(
	MANDANT_ID COMMENT 'Mandant im DWH',
	BESTELL_BELEG_NR COMMENT 'Belegnummer der Bestellung auf die sich das Obligo bezieht.',
	BESTELL_BELEG_POS_NR COMMENT 'Belegposition der Bestellung auf die sich das Obligo bezieht.',
	DAT_BELEG COMMENT 'Datum des Beleges für das Obligo.',
	KRK_ID COMMENT 'globale ID des Kostenrechnungskreises',
	KOSTENART_ID COMMENT 'Eindeutiger Fachschluessel fuer die Kostenarten',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_OBLIGO COMMENT 'Betrag des Obligo. Noch ausstehender Betrag zur Zahlung.',
	LOESCH_FG COMMENT 'Flag gibt an, ob Eintrag im Quellsystem wieder gelöscht wurde und nicht für das Reporting relevant ist.'
) COMMENT='Enthält das Obligo für die Bestellpositionen einer Bestellung. Unter Obligo versteht man die noch offenen Verbindlichkeiten.'
 as 
    SELECT 
        mandant_id,
        bestell_beleg_nr,
        bestell_beleg_pos_nr,
        dat_beleg,
        krk_id,
        kostenart_id,
        wrg_id,
        betrag_obligo,
        loesch_fg

FROM DBP_DATA.ZB_PROJEKT_OBLIGO ;
