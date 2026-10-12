--==============================================================
-- Table: l_werbeflaechenabschnitt_avq_prio_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenabschnitt_avq_prio_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEFLAECHENABSCHNITT_AVQ_PRIO_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   werbeflaechenabschnitt_avq_prio_nr  NUMBER(38,0)     NOT NULL COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.',
   werbeflaechenabschnitt_avq_prio_bez VARCHAR(200)     COMMENT 'Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEFLAECHENABSCHNITT_AVQ_PRIO PRIMARY KEY (mandant_id, werbeflaechenabschnitt_avq_prio_nr) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.';
