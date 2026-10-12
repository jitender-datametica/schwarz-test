create or replace TABLE KFL_PRODUCTION.DBP_DATA.MONAT_SPR_ZU_2 (
	MO_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Monats (zwischen 1 und 12)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	MO_BEZ VARCHAR(20) COLLATE 'en-ci' COMMENT 'Bezeichnung eines Kalendermonats',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_MONAT_SPR_ZU primary key (MO_ID, SPR_ID)
)COMMENT='Bezeichnung der Monate in den DWH-Sprachen'
;