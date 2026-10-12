create or replace view KFL_PRODUCTION.DBP_VIEW.V_WERBEWOCHE_KL(
	MANDANT_ID COMMENT 'Mandant im DWH',
	DAT COMMENT 'Datum im Format JJJJ-MM-TT',
	AKT_KJWO_WW COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche -1 und die nächste Woche den Wert 1',
	AKT_KJWO_WW_KOMPLETT COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2',
	KJWO_WW COMMENT 'Werbewoche, Format JJJJWW',
	ANGEPASSTE_KJWO_WW COMMENT 'Die tatsächliche Werbewoche, die meistens gegen Ende des Jahres manuell erweitert bzw. angepasst wird und leicht von kjwo_ww abweicht. ZB: In DE nicht immer von DO-MI die Werbwoche geht. 2023 war bspw. DO-DI der Werbwochenzeitraum vom 21.12-26.12.23 und MI-MI vom 27.12.23-03.01.24.'
) as 
    SELECT 
        mandant_id,
        dat,
        akt_kjwo_ww,
        akt_kjwo_ww_komplett,
        kjwo_ww,
        angepasste_kjwo_ww

FROM DBP_DATA.WERBEWOCHE_KL ;