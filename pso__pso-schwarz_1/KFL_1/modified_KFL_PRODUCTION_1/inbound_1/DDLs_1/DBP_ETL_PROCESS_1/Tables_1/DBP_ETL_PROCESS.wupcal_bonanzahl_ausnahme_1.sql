CREATE OR REPLACE TABLE WUPCAL_BONANZAHL_AUSNAHME_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	KASSE_NR INTEGER NOT NULL COMMENT 'Nummer der Kasse',
	DAT_VON DATE COMMENT 'Datum, ab dem die Ausnahme_1 gelten soll',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS Ladehilfstabelle - Bons dieser Kassen bei bonanzahl nicht berücksichtigen. Wird per Makro versorgt'
;