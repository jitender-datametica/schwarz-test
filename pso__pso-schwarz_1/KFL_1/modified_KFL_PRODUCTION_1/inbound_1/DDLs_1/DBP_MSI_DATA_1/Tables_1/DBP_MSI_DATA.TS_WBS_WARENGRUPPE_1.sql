--==============================================================
-- Table: ts_wbs_warengruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_warengruppe_1
   generated from Powerdesigner on Dienstag, 29. April 2025 09:21:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_WARENGRUPPE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   kjwo                                INTEGER     NOT NULL COMMENT 'Werbekalenderwoche, JJJJWW.',
   wg_id                               INTEGER     NOT NULL COMMENT 'Warengruppe ID.',
   estimation_fg                       INTEGER     COMMENT 'Flag: Sagt aus, ob die betrachtete WG bei der Werbemengenfindung durch WBS berücksichtigt wird.',
   adjustment_id                       INTEGER     COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.
            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R
            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.
            2 = Platzhalter (Stand 28.03.2025)
            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_1 manuelle Bestellanlage durch das Land_1 notwendig. ',
   auto_bestellmenge_mit_bestand_phase_switch_i_fg INTEGER     COMMENT 'Flag: Bestimmung, ob für die Warengruppe die Werbebestellmenge automatisch mit Bestandsberückstigigung an die VZ-Disposition übertragen wird (0 = nein, 1 = ja). Betrifft die Bestellung beim Lieferanten. Phase Switch 1 betrifft den Wechsel von Phase 8 zu 6 und enhält die komplette Phase 7 (Switch 2 und 4 werden aufgrund von Prozessveränderungen aktuell nicht (mehr) benutzt). Ist da zur Vereinfachung der Bearbeitung und schreibt die Einstellung für alle Artikel_1 in der Warengruppe nach WBS_WERBEAENDERUNGEN.BESTELLUNG_LIEFERANT_MIT_BESTAND_FG, wo dann noch über MSTR pro Artikel_1 manuell verändert werden kann.
            Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 0: Beides ohne Bestandsberücksichtigung (z.B. bei Ultrafrische). Kompletter Bedarf ohne Abzüge wird bestellt und geliefert.
            Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 1: Erstberechnung und Bestellung beim Lieferanten ohne Bestandsberücksichtigung, also die komplette Menge. Vor initialer Belieferung wird der Bestand aber mitberücksichtigt, was dann Reste im VZ bedeutet.
            Wenn Phase-Switch I Flag = 1 und Phase-Switch III Flag = 0: Erstberechnung mit Bestand und Bestellung beim Lieferanten. Für die Berechnung der initialen Belieferung wird nicht nochmal Bestand mit berücksichtigt weil es einen doppelten Abzug bedeuten würde. Ursprüngliche Menge aus Erstberechnung mit Bestandsberücksichtigung wird 1:1 rausgeschickt.
            Wenn Phase-Switch I Flag = 1 und Phase-Switch III Flag = 1: Bestellung beim Lieferanten erfolgt mit Bestandsberücksichtigung sowie erneute Bestandsberücksichtigung bei initialer Belieferung. Sollte als automatischer Standard nicht passieren da einen doppelten Abzug zur Folge haben würde und kein Use-Case ist. Wäre_1 theoretisch aber möglich durch manuelle Änderung im MSTR-Tool.',
   auto_bestellmenge_mit_bestand_phase_switch_iii_fg INTEGER     COMMENT 'Flag: Bestimmung, ob für die Warengruppe die Werbebemenge automatisch mit Bestandsberücksichtigung bei der initialen Belieferung berechnet wird (0 = nein, 1 = ja). Ist da zur Vereinfachung der Bearbeitung und kann pro Artikel_1 noch manuell verändert  werden. Phase Switch 3 betrifft den Eintritt der Phase 2 (Switch 2 und 4 werden aufgrund von Prozessveränderungen aktuell nicht (mehr) benutzt). Betrifft die initiale Belieferung der Märkte.
            Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 0: Beides ohne Bestandsberücksichtigung (z.B. bei Ultrafrische). Kompletter Bedarf ohne Abzüge wird bestellt und geliefert.
            Wenn Phase-Switch I Flag = 0 und Phase-Switch III Flag = 1: Erstberechnung und Bestellung beim Lieferanten ohne Bestandsberücksichtigung, also die komplette Menge. Vor initialer Belieferung wird der Bestand aber mitberücksichtigt, was dann Reste im VZ bedeutet.
            Wenn Phase-Switch I Flag = 1 und Phase-Switch III Flag = 0: Erstberechnung mit Bestand und Bestellung beim Lieferanten. Für die Berechnung der initialen Belieferung wird nicht nochmal Bestand mit berücksichtigt weil es einen doppelten Abzug bedeuten würde. Ursprüngliche Menge aus Erstberechnung mit Bestandsberücksichtigung wird 1:1 rausgeschickt.
            Wenn Phase-Switch I Flag = 1 und Phase-Switch III Flag = 1: Bestellung beim Lieferanten erfolgt mit Bestandsberücksichtigung sowie erneute Bestandsberücksichtigung bei initialer Belieferung. Sollte als automatischer Standard nicht passieren da einen doppelten Abzug zur Folge haben würde und kein Use-Case ist. Wäre_1 theoretisch aber möglich durch manuelle Änderung im MSTR-Tool.',
   bonuskauf_promotionstyp             VARCHAR(4)       COMMENT 'Promotion Type (Field AKART in PMR) , expected entries e.g. 0001, 0005, ZAI, ZBBR.
            gibt die Aktionsart für eine_1 Aktion_ID an Z.B:
            Aktionsart ''0001'' eine_1 Standard-Aktion_1 im Prospekt
            oder ''ZBBR'' wäre_1 eine_1 Bonuskauf-Aktion.
            die Art_1 der Aktion_1 hat Einfluss darauf, ob und wie die SCM-Mengen für diese Aktion_1 berechnet werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_WARENGRUPPE PRIMARY KEY (mandant_id, kjwo, wg_id) NOT ENFORCED
)  COMMENT = 'SCM-WBS - This table contains the settings for WBS calculation core on WG level (Warengruppe). Content is maintained by transaction services document. Promotional weeks are added in advance and each newly added week is pre-filled from TS_WBS_WARENGRUPPE_STANDARD. Users can make changes to the settings, in which case the contents here are overwritten.';
