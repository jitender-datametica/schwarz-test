CREATE TABLE DBP_DATA.WOCHE_1 (
	GJWO INTEGER COMMENT 'Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW',
	GJWO_VJ INTEGER COMMENT 'Der Geschäftsjahrewoche entsprechende Woche_1 im Vorjahr, Format JJJJWW',
	KJWO INTEGER COMMENT 'Kalenderjahreswoche. Format JJJJWW',
	KJWO_VJ INTEGER COMMENT 'Der Kalenderjahrwoche entsprechende Woche_1 im Vorjahr, Format JJJJWW',
	WO_DAT_VON DATE,
	WO_DAT_BIS DATE,
	AKT_WO INTEGER COMMENT 'Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1',
	AKT_WO_KOMPLETT INTEGER COMMENT 'Zahlenfolge, die den Abstand einer Woche_1 zur letzten abgeschlossenen Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 1, die vorige Woche_1 0 und die nächste Woche_1  den Wert 2',
	AKT_WO_KALENDARISCH INTEGER COMMENT 'Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9),
	KJWO_VVJ INTEGER NOT NULL DEFAULT 0 COMMENT 'Kalenderwoche im Vorvorjahr',
	unique (GJWO)
)COMMENT='Enthält Kalenderdaten auf Wochenebene'
;