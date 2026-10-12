create or replace TABLE KFL_PRODUCTION.DBP_DATA.VKL (
	VKL_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Verkaufsleiters',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	GF_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftsführer ID, numerisch',
	VKL_NAME VARCHAR(320) COMMENT 'Name des Verkaufsleiters',
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9)
)COMMENT='VIS - Lookup Tabelle Verkaufsleiter'
;