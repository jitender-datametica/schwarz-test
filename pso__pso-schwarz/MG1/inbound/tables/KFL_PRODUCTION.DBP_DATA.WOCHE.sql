create or replace TABLE KFL_PRODUCTION.DBP_DATA.WOCHE (
	GJWO NUMBER(38,0) COMMENT 'Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW',
	GJWO_VJ NUMBER(38,0) COMMENT 'Der Geschäftsjahrewoche entsprechende Woche im Vorjahr, Format JJJJWW',
	KJWO NUMBER(38,0) COMMENT 'Kalenderjahreswoche. Format JJJJWW',
	KJWO_VJ NUMBER(38,0) COMMENT 'Der Kalenderjahrwoche entsprechende Woche im Vorjahr, Format JJJJWW',
	WO_DAT_VON DATE,
	WO_DAT_BIS DATE,
	AKT_WO NUMBER(38,0) COMMENT 'Zahlenfolge, die den Abstand einer Woche zur laufenden Woche darstellt. Die aktuelle Woche hat den Wert 0, die vorige Woche -1 und die nächste Woche den Wert 1',
	AKT_WO_KOMPLETT NUMBER(38,0) COMMENT 'Zahlenfolge, die den Abstand einer Woche zur letzten abgeschlossenen Woche darstellt. Die aktuelle Woche hat den Wert 1, die vorige Woche 0 und die nächste Woche  den Wert 2',
	AKT_WO_KALENDARISCH NUMBER(38,0) COMMENT 'Zahlenfolge, die den Abstand einer Woche zur laufenden Woche darstellt. Die aktuelle Woche hat den Wert 0, die vorige Woche -1 und die nächste Woche den Wert 1',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9),
	KJWO_VVJ NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kalenderwoche im Vorvorjahr',
	unique (GJWO)
)COMMENT='Enthält Kalenderdaten auf Wochenebene'
;