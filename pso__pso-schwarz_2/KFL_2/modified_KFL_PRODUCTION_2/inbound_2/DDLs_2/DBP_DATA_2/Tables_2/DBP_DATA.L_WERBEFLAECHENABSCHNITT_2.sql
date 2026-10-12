--==============================================================
-- Table: l_werbeflaechenabschnitt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenabschnitt_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEFLAECHENABSCHNITT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   werbeflaechenabschnitt_id           INTEGER     NOT NULL COMMENT 'ID des Werbeflächenabschnitts',
   werbeflaechenabschnitt_avq_prio_nr  INTEGER     COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEFLAECHENABSCHNITT PRIMARY KEY (mandant_id, werbeflaechenabschnitt_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für den Werbeflächenabschnitt. Aus ZPMR_WBM_ABSBEZ(SAP P11). Enthält sowohl die Werbeflächenabschnitts-Bezeichnungen aus SAP, als auch die Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).
             Der Werbeflächenabschnitt gibt an, in welchem Abschnitt eines Bereichs das Angebot_2 abgebildet ist (z.B. TOPLEFT1 = oben links auf der Seite im Prospekt).';
