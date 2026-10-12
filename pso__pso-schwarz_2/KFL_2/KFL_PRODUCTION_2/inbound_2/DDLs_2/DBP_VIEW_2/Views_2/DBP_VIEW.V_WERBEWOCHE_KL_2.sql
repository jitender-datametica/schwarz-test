CREATE OR REPLACE VIEW DBP_VIEW.V_WERBEWOCHE_KL_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_2-TT'
  ,akt_kjwo_ww                              COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche_2 -1 und die nächste Woche_2 den Wert 1'
  ,akt_kjwo_ww_komplett                     COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2'
  ,kjwo_ww                                  COMMENT 'Werbewoche, Format JJJJWW'
  ,angepasste_kjwo_ww                       COMMENT 'Die tatsächliche Werbewoche, die meistens gegen Ende des Jahres manuell erweitert bzw. angepasst wird und leicht von kjwo_ww abweicht. ZB: In DE nicht immer von DO-MI die Werbwoche geht. 2023 war bspw. DO-DI der Werbwochenzeitraum vom 21.12-26.12.23 und MI-MI vom 27.12.23-03.01.24.'
)
COMMENT = 'AIS - Enthält Kalenderdaten auf Werbewochen-Ebene'
 AS 
    SELECT 
        mandant_id,
        dat,
        akt_kjwo_ww,
        akt_kjwo_ww_komplett,
        kjwo_ww,
        angepasste_kjwo_ww

FROM DBP_DATA.WERBEWOCHE_KL_2 ;