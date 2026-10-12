CREATE OR REPLACE TABLE WUPCAL_BONANZAHL_AUSNAHME (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	KASSE_NR NUMBER(38,0) NOT NULL COMMENT 'Nummer der Kasse',
	DAT_VON DATE COMMENT 'Datum, ab dem die Ausnahme gelten soll',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS Ladehilfstabelle - Bons dieser Kassen bei bonanzahl nicht berücksichtigen. Wird per Makro versorgt'
;