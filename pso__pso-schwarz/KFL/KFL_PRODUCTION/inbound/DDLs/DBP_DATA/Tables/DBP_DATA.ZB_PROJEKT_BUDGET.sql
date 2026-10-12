create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ZB_PROJEKT_BUDGET (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	PROJEKT_NR VARCHAR(100) NOT NULL COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BUDGET_TYP_CD VARCHAR(20) NOT NULL COMMENT 'Code des Budget Typs. (A1 = Budget bei Freigabe, A2 = Aktuelles Budget)',
	BUDGET_VERSION_NAME VARCHAR(100) COMMENT 'Name der aktuellen Version des Budgets.',
	DAT_BUDGET DATE COMMENT 'Datum an dem das Budget geplant wurde.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_BUDGET NUMBER(38,5) NOT NULL COMMENT 'Wert des Budgets für den einzelnen Budgettyp pro Gewerk.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ZB_PROJEKT_BUDGET primary key (MANDANT_ID, PROJEKT_NR, GEWERK_ID, BUDGET_TYP_CD)
)COMMENT='Enthält die geplanten Budgets für die einzelnen Gewerke eines Projektes aus den Zentralbereichen'
;
