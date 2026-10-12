create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_ZB_PROJEKT_GEWERK_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	WRG_TYP_ID COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_ZEK COMMENT 'Betrag der zu erwartenden Mehr- bzw. Minderkosten des Projektes auf Ebene Gewerk',
	ANMERKUNG_TXT COMMENT 'Freitext für Anmerkungen zum Bericht auf Ebene Projekt, Gewerk.'
) COMMENT='TS-Tabelle auf Ebene Projekt und Gewerk für zusätzliche Projektdaten aus den Zentralbereichen'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        wrg_typ_id,
        wrg_id,
        betrag_zek,
        anmerkung_txt

FROM DBP_MSI_DATA.TS_ZB_PROJEKT_GEWERK_1 ;
