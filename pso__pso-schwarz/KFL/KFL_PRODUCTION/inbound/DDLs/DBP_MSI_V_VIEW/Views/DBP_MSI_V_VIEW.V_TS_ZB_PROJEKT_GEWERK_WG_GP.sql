create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_ZB_PROJEKT_GEWERK_WG_GP(
	MANDANT_ID COMMENT 'Mandant im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	WARENGRUPPE_CD COMMENT 'Code der Warengruppe',
	GP_ID COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	ANMERKUNG_TXT COMMENT 'Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk, Warengruppe, GP',
	NICHT_RELEVANT_FG COMMENT 'Flag gibt an, ob der Datensatz für die Berechnung der Gesamtsummen relevant (0) ist oder nicht (1).'
) COMMENT='TS-Tabelle auf Ebene Projekt, Gewerk, Warengruppe und GP für zusätzliche Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich einer Bestellung zuordnen lassen.'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        warengruppe_cd,
        gp_id,
        anmerkung_txt,
        nicht_relevant_fg

FROM DBP_MSI_DATA.TS_ZB_PROJEKT_GEWERK_WG_GP ;
