CREATE TABLE DBP_DATA.GF_2 (
	GF_ID INTEGER NOT NULL COMMENT 'Geschäftsführer ID, numerisch',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	EK_FG INTEGER NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt',
	GF_NAME VARCHAR(160) COLLATE 'en-ci' COMMENT 'Name des Geschäftsführers',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Lookup Tabelle  Geschäftsführer'
;