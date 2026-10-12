create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_BESTELLUNG(
	MANDANT_ID COMMENT 'Mandant im DWH',
	BESTELL_BELEG_NR COMMENT 'Belegnummer der Bestellung.',
	DAT_ERSTELLUNG COMMENT 'Erstelldatum der Bestellung.',
	GP_ID COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID COMMENT 'ID der Einkaufsorganisation aus ekorg'
) COMMENT='Enhält die erstellten Bestellungen (Kopfinformationen), die innerhalb von Projekten aus den Zentralbereichen erstellt werden.'
 as 
    SELECT 
        mandant_id,
        bestell_beleg_nr,
        dat_erstellung,
        gp_id,
        einkaufsorganisation_id

FROM DBP_DATA.ZB_PROJEKT_BESTELLUNG ;
