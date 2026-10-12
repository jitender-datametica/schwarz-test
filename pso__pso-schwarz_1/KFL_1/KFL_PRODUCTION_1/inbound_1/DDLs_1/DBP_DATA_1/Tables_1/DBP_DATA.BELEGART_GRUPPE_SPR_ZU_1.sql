create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BELEGART_GRUPPE_SPR_ZU_1 (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	BELEGART_GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierung über die Belegarten (fortlaufende Nummer)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
	BELEGART_GRUPPE_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung der Belegartengruppen (z.Bsp. Rechnungsbeleg, Gutschrift,...)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BELEGART_GRUPPE_SPR_ZU primary key (SYSTEM_ID, MANDANT_ID, BELEGART_GRUPPE_ID)
)COMMENT='RPW - DATA - Sprachtabhängige Bezeichnungen für die Gruppierung der Belegart\n             '
;
