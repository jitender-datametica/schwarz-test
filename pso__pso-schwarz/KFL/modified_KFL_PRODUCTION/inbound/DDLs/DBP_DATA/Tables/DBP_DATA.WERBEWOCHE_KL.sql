--==============================================================
-- Table: werbewoche_kl
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbewoche_kl
   generated from Powerdesigner on Dienstag, 10. Juni 2025 18:05:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WERBEWOCHE_KL (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   akt_kjwo_ww                         INTEGER     NOT NULL COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche -1 und die nächste Woche den Wert 1',
   akt_kjwo_ww_komplett                INTEGER     NOT NULL DEFAULT 0 COMMENT 'Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2',
   kjwo_ww                             INTEGER     NOT NULL COMMENT 'Werbewoche, Format JJJJWW',
   angepasste_kjwo_ww                  INTEGER     COMMENT 'Die tatsächliche Werbewoche, die meistens gegen Ende des Jahres manuell erweitert bzw. angepasst wird und leicht von kjwo_ww abweicht. ZB: In DE nicht immer von DO-MI die Werbwoche geht. 2023 war bspw. DO-DI der Werbwochenzeitraum vom 21.12-26.12.23 und MI-MI vom 27.12.23-03.01.24.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WERBEWOCHE_KL PRIMARY KEY (mandant_id, dat) NOT ENFORCED
)  COMMENT = 'AIS - Enthält Kalenderdaten auf Werbewochen-Ebene';