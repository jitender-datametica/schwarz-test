CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WERBEWOCHE_KL_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
AKT_KJWO_WW INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche_2 -1 und die nächste Woche_2 den Wert 1'),
AKT_KJWO_WW_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2'),
KJWO_WW INTEGER NOT NULL OPTIONS(description='Werbewoche, Format JJJJWW'),
ANGEPASSTE_KJWO_WW INTEGER
OPTIONS(description='Die tatsächliche Werbewoche, die meistens gegen Ende des Jahres manuell erweitert bzw. angepasst wird und leicht von kjwo_ww abweicht. ZB: In DE nicht immer von DO-MI die Werbwoche geht. 2023 war bspw. DO-DI der Werbwochenzeitraum vom 21.12-26.12.23 und MI-MI vom 27.12.23-03.01.24.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, DAT) NOT ENFORCED
) OPTIONS(description='AIS - Enthält Kalenderdaten auf Werbewochen-Ebene');