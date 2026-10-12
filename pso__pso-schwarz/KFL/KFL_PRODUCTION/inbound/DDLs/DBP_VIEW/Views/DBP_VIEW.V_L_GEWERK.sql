create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_GEWERK(
	MANDANT_ID COMMENT 'Mandant im DWH',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	FINANZ_GRUPPE_NR COMMENT 'Alphanumerische Nummer der Finanzgruppe. Jedes Gewerk besitzt genau eine dazugehörige Finanzgruppe. Über diese Nummer kann bspw. das Budget zum Projekt gemapped werden.'
) as 
    SELECT 
        mandant_id,
        gewerk_id,
        finanz_gruppe_nr

FROM DBP_DATA.L_GEWERK ;
