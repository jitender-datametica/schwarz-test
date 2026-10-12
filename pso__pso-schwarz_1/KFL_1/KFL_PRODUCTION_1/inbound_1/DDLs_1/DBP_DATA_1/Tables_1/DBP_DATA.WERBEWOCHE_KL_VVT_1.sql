CREATE TABLE DBP_DATA.WERBEWOCHE_KL_VVT_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
	AKT_KJWO_WW NUMBER(38,0) NOT NULL COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1',
	AKT_KJWO_WW_KOMPLETT NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2',
	KJWO_WW NUMBER(38,0) NOT NULL COMMENT 'Werbewoche, Format JJJJWW',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='AIS - Enthält Kalenderdaten auf Werbewochen-Ebene mit VorVorTagslogik'
;