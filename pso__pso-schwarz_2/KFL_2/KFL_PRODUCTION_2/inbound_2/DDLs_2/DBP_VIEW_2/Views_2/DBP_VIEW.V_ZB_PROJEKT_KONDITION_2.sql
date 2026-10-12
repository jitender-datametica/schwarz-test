create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_KONDITION_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	KONDITION_NR COMMENT 'Nummer der Kondition',
	KONDITIONSTYP_ID COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	MV_INTRENO COMMENT 'Interner Schlüssel des Mietvertrages',
	GP_ID COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	PARTNER_ID COMMENT 'Geschäftspartnernummer',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KONDITION COMMENT 'Betrag der Kondition'
) COMMENT='Enthält Konditionen zu Verträgen die für ein Projekt gültig sind.'
 as 
    SELECT 
        mandant_id,
        kondition_nr,
        konditionstyp_id,
        projekt_nr,
        gewerk_id,
        mv_intreno,
        gp_id,
        partner_id,
        wrg_id,
        betrag_kondition

FROM DBP_DATA.ZB_PROJEKT_KONDITION_2 ;
