create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_PROJEKTTERMIN_ZU_PER_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	PROJEKTTERMIN_CD COMMENT 'Code des Projekttermins.',
	DAT_VON COMMENT 'Beginn der Gültigkeit, Teil der DWH-Historisierung.',
	DAT_BIS COMMENT 'Ende der Gültigkeit, Teil der DWH-Historisierung.',
	DAT_TERMIN_IST COMMENT 'Ist-Datum des Termins.',
	DAT_TERMIN_PROGNOSE COMMENT 'Prognostiziertes Datum des Termins.'
) COMMENT='Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und allen darin vorhandenen Termine.'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        projekttermin_cd,
        dat_von,
        dat_bis,
        dat_termin_ist,
        dat_termin_prognose

FROM DBP_DATA.ZB_PROJEKT_PROJEKTTERMIN_ZU_PER_1 ;
