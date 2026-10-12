create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WOCHE_1 (
	GJWO NUMBER(38,0) COMMENT 'Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW',
	GJWO_VJ NUMBER(38,0) COMMENT 'Der Geschäftsjahrewoche entsprechende Woche_1 im Vorjahr, Format JJJJWW',
	KJWO NUMBER(38,0) COMMENT 'Kalenderjahreswoche. Format JJJJWW',
	KJWO_VJ NUMBER(38,0) COMMENT 'Der Kalenderjahrwoche entsprechende Woche_1 im Vorjahr, Format JJJJWW',
	WO_DAT_VON DATE,
	WO_DAT_BIS DATE,
	AKT_WO NUMBER(38,0) COMMENT 'Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1',
	AKT_WO_KOMPLETT NUMBER(38,0) COMMENT 'Zahlenfolge, die den Abstand einer Woche_1 zur letzten abgeschlossenen Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 1, die vorige Woche_1 0 und die nächste Woche_1  den Wert 2',
	AKT_WO_KALENDARISCH NUMBER(38,0) COMMENT 'Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9),
	KJWO_VVJ NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kalenderwoche im Vorvorjahr',
	unique (GJWO)
)COMMENT='Enthält Kalenderdaten auf Wochenebene'
;
