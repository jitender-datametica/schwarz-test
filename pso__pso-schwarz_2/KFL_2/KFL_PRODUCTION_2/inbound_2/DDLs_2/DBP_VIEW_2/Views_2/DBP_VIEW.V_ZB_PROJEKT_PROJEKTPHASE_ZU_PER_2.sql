create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ZB_PROJEKT_PROJEKTPHASE_ZU_PER_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	PROJEKTPHASE_ID COMMENT 'ID der Projektphase',
	DAT_VON COMMENT 'Beginn der Gültigkeit, Teil der DWH-Historisierung.',
	DAT_BIS COMMENT 'Ende der Gültigkeit, Teil der DWH-Historisierung.',
	PROJEKTPHASE_STATUS_ID COMMENT 'ID des Status_2 der Projektphase.',
	PROJEKTPHASE_AKTIV_FG COMMENT 'Kennzeichen, ob die Phase aktuell aktiv im Projekt ist (1) oder nicht (2).'
) COMMENT='Zuordnungstabelle zwischen einem Projekt aus den Zentralbereichen und den möglichen Projektphasen'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        projektphase_id,
        dat_von,
        dat_bis,
        projektphase_status_id,
        projektphase_aktiv_fg

FROM DBP_DATA.ZB_PROJEKT_PROJEKTPHASE_ZU_PER_2 ;
