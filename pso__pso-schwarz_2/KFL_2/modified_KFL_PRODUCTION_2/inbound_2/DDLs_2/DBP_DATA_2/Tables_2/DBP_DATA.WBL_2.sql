CREATE TABLE DBP_DATA.WBL_2 (
	WBL_ID INTEGER NOT NULL COMMENT 'Warenbereichsleiter ID',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	WBL_DAT_VON DATE COMMENT 'Gültig-ab Datum des Warenbereichsleiters',
	WBL_NAME VARCHAR(160) COLLATE 'en-ci' COMMENT 'Name des Warenbereichsleiters',
	GF_ID INTEGER COMMENT 'Geschäftsführer ID',
	EK_FG INTEGER NOT NULL COMMENT 'Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Warenbereichsleiter '
;