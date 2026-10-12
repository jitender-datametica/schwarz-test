CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WOCHE_1 (
GJWO INTEGER
OPTIONS(description='Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW'),
GJWO_VJ INTEGER OPTIONS(description='Der Geschäftsjahrewoche entsprechende Woche_1 im Vorjahr, Format JJJJWW'),
KJWO INTEGER OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
KJWO_VJ INTEGER OPTIONS(description='Der Kalenderjahrwoche entsprechende Woche_1 im Vorjahr, Format JJJJWW'),
WO_DAT_VON DATE,
WO_DAT_BIS DATE,
AKT_WO INTEGER
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1'),
AKT_WO_KOMPLETT INTEGER
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_1 zur letzten abgeschlossenen Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 1, die vorige Woche_1 0 und die nächste Woche_1  den Wert 2'),
AKT_WO_KALENDARISCH INTEGER
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP,
KJWO_VVJ INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kalenderwoche im Vorvorjahr')
) OPTIONS(description='Enthält Kalenderdaten auf Wochenebene');