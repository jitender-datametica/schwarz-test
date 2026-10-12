create or replace TABLE KFL_PRODUCTION.DBP_DATA.WBL_2 (
	WBL_ID NUMBER(38,0) NOT NULL COMMENT 'Warenbereichsleiter ID',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WBL_DAT_VON DATE COMMENT 'Gültig-ab Datum des Warenbereichsleiters',
	WBL_NAME VARCHAR(160) COLLATE 'en-ci' COMMENT 'Name des Warenbereichsleiters',
	GF_ID NUMBER(38,0) COMMENT 'Geschäftsführer ID',
	EK_FG NUMBER(38,0) NOT NULL COMMENT 'Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Warenbereichsleiter '
;