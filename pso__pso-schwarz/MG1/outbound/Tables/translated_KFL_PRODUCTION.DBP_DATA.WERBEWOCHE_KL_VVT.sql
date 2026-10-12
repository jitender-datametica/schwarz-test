CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WERBEWOCHE_KL_VVT (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
AKT_KJWO_WW INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche -1 und die nächste Woche den Wert 1'),
AKT_KJWO_WW_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2'),
KJWO_WW INTEGER NOT NULL OPTIONS(description='Werbewoche, Format JJJJWW'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='AIS - Enthält Kalenderdaten auf Werbewochen-Ebene mit VorVorTagslogik');