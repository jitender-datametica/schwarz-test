create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_PROJEKTPHASE_ZU_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	PROJEKTPHASE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Projektphase',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeit, Teil der DWH-Historisierung.',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeit, Teil der DWH-Historisierung.',
	PROJEKTPHASE_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Status_2 der Projektphase.',
	PROJEKTPHASE_AKTIV_FG NUMBER(38,0) NOT NULL COMMENT 'Kennzeichen, ob die Phase aktuell aktiv im Projekt ist (1) oder nicht (2).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_PROJEKTPHASE_ZU_PER primary key (MANDANT_ID, PROJEKT_NR, PROJEKTPHASE_ID, DAT_VON)
)COMMENT='Zuordnungstabelle zwischen einem Projekt aus den Zentralbereichen und den möglichen Projektphasen'
;
