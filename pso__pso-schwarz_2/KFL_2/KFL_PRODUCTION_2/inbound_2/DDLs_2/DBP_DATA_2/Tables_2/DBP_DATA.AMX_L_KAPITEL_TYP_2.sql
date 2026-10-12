create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.AMX_L_KAPITEL_TYP_2 (
	KAPITEL_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID des Prüfprogrammtyps aus dem Quellfeld id',
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
	KAPITEL_TYP_BEZ VARCHAR(255) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des prüfprogrammtyps aus dem Quellfeld name',
	AMX_GRP_ID NUMBER(38,0) COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen\n            ',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AMX_L_KAPITEL_TYP primary key (KAPITEL_TYP_ID, AMX_SYSTEM_ID)
)COMMENT='VIS audimex - Lookup Tabelle der Prüf-Programm-Typen aus der Quelltabelle audimex.audit_concept_type'
;
