CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbewoche_kl_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'), dat
OPTIONS(description='Datum im Format JJJJ-MM_1-TT'), akt_kjwo_ww
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1'),
akt_kjwo_ww_komplett
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2'),
kjwo_ww OPTIONS(description='Werbewoche, Format JJJJWW'), angepasste_kjwo_ww
OPTIONS(description='Die tatsächliche Werbewoche, die meistens gegen Ende des Jahres manuell erweitert bzw. angepasst wird und leicht von kjwo_ww abweicht. ZB: In DE nicht immer von DO-MI die Werbwoche geht. 2023 war bspw. DO-DI der Werbwochenzeitraum vom 21.12-26.12.23 und MI-MI vom 27.12.23-03.01.24.'))
AS SELECT mandant_id,
 dat,
 akt_kjwo_ww,
 akt_kjwo_ww_komplett,
 kjwo_ww,
 angepasste_kjwo_ww
FROM kfl_production_dbp_data.werbewoche_kl_1;