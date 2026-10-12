create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_ZB_FAKT_BUCHUNG_VERTRAG_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	VERTRAG_NR COMMENT 'Nummer des Vertrages.',
	GP_ID COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WRG_TYP_ID COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VERTRAG COMMENT 'Betrag der Vertragswerte auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk'
) as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        vertrag_nr,
        gp_id,
        wrg_typ_id,
        wrg_id,
        betrag_vertrag,
        betrag_obligo,
        betrag_buchung

FROM DBP_MSI_DATA.ZB_FAKT_BUCHUNG_VERTRAG_1 ;
