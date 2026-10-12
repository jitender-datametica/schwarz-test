create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ROHSTOFF_1 (
	ROHSTOFF_NR VARCHAR(200) NOT NULL COMMENT 'Mintecs Interne ID des Rohstoffs.',
	ROHSTOFF_BASIS_EINH_NAME VARCHAR(100) NOT NULL COMMENT 'Die Basiseinheit des Rohstoffs (native).',
	ROHSTOFF_BEZ VARCHAR(300) NOT NULL COMMENT 'Bezeichnung des Rohstoffs.',
	ROHSTOFF_KFL_BEZ VARCHAR(300) NOT NULL COMMENT 'Kaufland interne Bezeichnung des Rohstoffs.',
	ROHSTOFF_BESCHREIBUNG_TXT VARCHAR(1000) NOT NULL COMMENT 'Beschreibung des Rohstoffs.',
	ROHSTOFF_QUALITAET_TXT VARCHAR(1000) COMMENT 'Beschreibung der Qualität des Rohstoffs.',
	ROHSTOFF_HERKUNFTSORT_NAME VARCHAR(100) COMMENT 'Herkunfsort des Rohstoffs - Dieser kann Land_1, Region_1 oder Länderguppe sein.',
	ROHSTOFF_LIEFERORT_NAME VARCHAR(100) NOT NULL COMMENT 'Land_1, Region_1 oder Ländergruppe, die den Rohstof fliefert.',
	ROHSTOFF_QUELL_BEZ VARCHAR(200) COMMENT 'Enthält Informationen zur Quelle des Rohstoffes.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ROHSTOFF primary key (ROHSTOFF_NR)
)COMMENT='Diese Tabelle enthält Informationen über die Rohstoffe verwendet bei Kaufland.'
;
