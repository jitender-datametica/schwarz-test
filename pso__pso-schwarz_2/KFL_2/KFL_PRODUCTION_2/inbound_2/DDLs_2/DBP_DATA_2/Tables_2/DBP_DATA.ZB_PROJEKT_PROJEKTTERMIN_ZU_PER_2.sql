create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_PROJEKTTERMIN_ZU_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	PROJEKTTERMIN_CD VARCHAR(100) NOT NULL COMMENT 'Code des Projekttermins.',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeit, Teil der DWH-Historisierung.',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeit, Teil der DWH-Historisierung.',
	DAT_TERMIN_IST DATE COMMENT 'Ist-Datum des Termins.',
	DAT_TERMIN_PROGNOSE DATE NOT NULL COMMENT 'Prognostiziertes Datum des Termins.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_PROJEKTTERMIN_ZU_PER primary key (MANDANT_ID, PROJEKT_NR, PROJEKTTERMIN_CD, DAT_VON)
)COMMENT='Zuordnungstabelle zwischen einem  Projekt aus den Zentralbereichen und allen darin vorhandenen Termine.'
;
