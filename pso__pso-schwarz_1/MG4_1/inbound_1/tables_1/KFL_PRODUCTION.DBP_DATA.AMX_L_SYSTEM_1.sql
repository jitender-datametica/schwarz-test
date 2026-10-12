create or replace TABLE KFL_PRODUCTION.DBP_DATA.AMX_L_SYSTEM_1 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Amx System ID zur unterscheidung der verschiedenen AMX Systeme',
	AMX_SYSTEM_BEZ VARCHAR(20) COLLATE 'en-ci' COMMENT 'Bezeichnung der unterschiedlichen AMX Systeme',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AMX_L_SYSTEM primary key (AMX_SYSTEM_ID)
)COMMENT='Lookup Tabelle für die unterschiedlichen AMX Quellsysteme.\n             '
;