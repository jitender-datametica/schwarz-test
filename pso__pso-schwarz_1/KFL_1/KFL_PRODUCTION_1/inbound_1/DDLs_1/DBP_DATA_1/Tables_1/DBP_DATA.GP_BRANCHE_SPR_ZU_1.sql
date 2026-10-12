create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GP_BRANCHE_SPR_ZU_1 (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	GP_BRANCHE_ID VARCHAR(4) NOT NULL COMMENT 'Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). Referenz zu der Tabelle l_gp_branche_1',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
	GP_BRANCHE_BEZ VARCHAR(40) COMMENT 'Sprachabhaengige Kurzbezeichnung der Banchen der Lieferanten.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GP_BRANCHE_SPR_ZU primary key (SYSTEM_ID, MANDANT_ID, GP_BRANCHE_ID, SPR_ID)
)COMMENT='RPW - Sprachabhaengige Bezeichnung der Lieferantenbranchen aus der Tabelle T016T des Quellsystems SAP. Es wird fuer jede DWH Sprache ein Eintrag hinterlegt. Standardbezeichnung ist die deusche Bezeichnung.'
;
