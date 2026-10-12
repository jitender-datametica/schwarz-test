create or replace TABLE KFL_PRODUCTION.DBP_DATA.BEDIENKONZEPT_AUSPR_SPR_ZU (
	BEDIENKONZEPT_ID NUMBER(38,0) NOT NULL COMMENT 'Die bedienkonzept_id wird im DWH vergeben',
	BEDIENKONZEPT_AUSPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Ausprägung des Bedienkonzepts',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
	BEDIENKONZEPT_AUSPR_BEZ VARCHAR(50) COLLATE 'en-ci' COMMENT 'Bezeichnung der Ausprägung des Bedienkonzepts, z.Bsp. Bedienung, separate Leergutannahme',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BEDIENKONZEPT_AUSPR_SPR_ZU primary key (BEDIENKONZEPT_ID, BEDIENKONZEPT_AUSPR_ID, SPR_ID)
)COMMENT='RPM -  Sprachabhängige Bezeichnung der Ausprägung der Bedienkonzepte'
;