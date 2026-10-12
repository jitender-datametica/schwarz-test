create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_BESTELLUNG_DET_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	BESTELL_BELEG_NR COMMENT 'Belegnummer der Bestellung.',
	BESTELL_BELEG_POS_NR COMMENT 'Nummer der Belegposition der Bestellung.',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BESTELL_BELEG_POS_TYP_CD COMMENT 'Code der angibt, um welchen Positionstyp der Bestellung es sich handelt, bspw. N = Nachtrag.',
	DAT_ERSTELLUNG COMMENT 'Erstelldatum der Belegposition.',
	MATERIAL_NR COMMENT 'Nummer des bestellten Materials.',
	WARENGRUPPE_CD COMMENT 'Code der Warengruppe',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR für betrag_netto',
	BETRAG_NETTO COMMENT 'Nettobetrag der Bestellposition in Landeswährung',
	BETRAG_NETTO_KONZ COMMENT 'Nettobetrag der Bestellposition in Konzernwährung (EUR)',
	RATE_TAGESKURS COMMENT 'Rate für die Umrechnung der lokalen Währung zur Konzernwährung mit dem Tageskurs.',
	BESTELL_POS_TXT COMMENT 'Freitext für die Belegposition.',
	ENDRECHNUNG_FG COMMENT 'Flag gibt an, ob ...............',
	LOESCH_FG COMMENT 'Flag gibt an, ob Belegposition gelöscht wurde und für das Reporting nicht relevant ist.'
) COMMENT='Enthält die Bestellpositionen der getätigten Bestellung für Projekte aus den Zentralbereichen.'
 as 
    SELECT 
        mandant_id,
        bestell_beleg_nr,
        bestell_beleg_pos_nr,
        projekt_nr,
        gewerk_id,
        bestell_beleg_pos_typ_cd,
        dat_erstellung,
        material_nr,
        warengruppe_cd,
        wrg_id,
        betrag_netto,
        betrag_netto_konz,
        rate_tageskurs,
        bestell_pos_txt,
        endrechnung_fg,
        loesch_fg

FROM DBP_DATA.ZB_PROJEKT_BESTELLUNG_DET_1 ;
