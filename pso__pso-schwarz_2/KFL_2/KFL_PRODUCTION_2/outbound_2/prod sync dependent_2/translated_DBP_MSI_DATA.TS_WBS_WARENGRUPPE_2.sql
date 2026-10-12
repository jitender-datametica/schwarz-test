CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_wbs_warengruppe_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
kjwo INTEGER NOT NULL OPTIONS(description='Werbekalenderwoche, JJJJWW.'),
wg_id INTEGER NOT NULL OPTIONS(description='Warengruppe ID.'),
estimation_fg INTEGER
OPTIONS(description='Flag: Sagt aus, ob die betrachtete WG bei der Werbemengenfindung durch WBS berücksichtigt wird.'),
adjustment_id INTEGER
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n            2 = Platzhalter (Stand 28.03.2025)\n            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_2 manuelle Bestellanlage durch das Land_2 notwendig. '),
auto_bestellmenge_mit_bestand_phase_switch_i_fg INTEGER
OPTIONS(description='Flag: Bestimmung, ob für die Warengruppe die Werbebestellmenge automatisch mit Bestandsberückstigigung an die VZ-Disposition übertragen wird (0 = nein, 1 = ja). Betrifft die Bestellung beim Lieferanten. Phase Switch 1 betrifft den Wechsel von Phase 8 zu 6 und enhält die komplette Phase 7 (Switch 2 und 4 werden aufgrund von Prozessveränderungen aktuell nicht (mehr) benutzt). Ist da zur Vereinfachung der Bearbeitung und schreibt die Einstellung für alle Artikel_2 in der Warengruppe nach WBS_WERBEAENDERUNGEN.BESTELLUNG_LIEFERANT_MIT_BESTAND_FG, wo dann noch über MSTR pro Artikel_2 manuell verändert werden kann.\n Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 0: Beides ohne Bestandsberücksichtigung (z.B. bei Ultrafrische). Kompletter Bedarf ohne Abzüge wird bestellt und geliefert.Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 1: Erstberechnung und Bestellung beim Lieferanten ohne'),
auto_bestellmenge_mit_bestand_phase_switch_iii_fg INTEGER
OPTIONS(description='Flag: Bestimmung, ob für die Warengruppe die Werbebemenge automatisch mit Bestandsberücksichtigung bei der initialen Belieferung berechnet wird (0 = nein, 1 = ja). Ist da zur Vereinfachung der Bearbeitung und kann pro Artikel_2 noch manuell verändert  werden. Phase Switch 3 betrifft den Eintritt der Phase 2 (Switch 2 und 4 werden aufgrund von Prozessveränderungen aktuell nicht (mehr) benutzt). Betrifft die initiale Belieferung der Märkte.\n Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 0: Beides ohne Bestandsberücksichtigung (z.B. bei Ultrafrische). Kompletter Bedarf ohne Abzüge wird bestellt und geliefert.\n Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 1: Erstberechnung und Bestellung beim Lieferanten ohne Bestandsberücksichtigung, also die komplette Menge. Vor initialer Belieferung wird der Bestand aber mitberücksichtigt, was dann Reste im VZ bedeutet.\n Wenn Phase-Switch I Flag = 1 und Phase-Switch III Flag = 0: Erstberechnung mit Bestand und Bestellung beim Lieferanten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
bonuskauf_promotionstyp STRING(4)
OPTIONS(description='Promotion Type (Field AKART in PMR) , expected entries e.g. 0001, 0005, ZAI, ZBBR.\n            gibt die Aktionsart für eine_2 Aktion_ID an Z.B:\n            Aktionsart\'0001\' eine_2 Standard-Aktion_2 im Prospekt\n            oder\'ZBBR\' wäre_2 eine_2 Bonuskauf-Aktion.\n            die Art_2 der Aktion_2 hat Einfluss darauf, ob und wie die SCM-Mengen für diese Aktion_2 berechnet werden.'),
PRIMARY KEY (mandant_id, kjwo, wg_id) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - This table contains the settings for WBS calculation core on WG level (Warengruppe). Content is maintained by transaction services document. Promotional weeks are added in advance and each newly added week is pre-filled from TS_WBS_WARENGRUPPE_STANDARD. Users can make changes to the settings, in which case the contents here are overwritten.');


