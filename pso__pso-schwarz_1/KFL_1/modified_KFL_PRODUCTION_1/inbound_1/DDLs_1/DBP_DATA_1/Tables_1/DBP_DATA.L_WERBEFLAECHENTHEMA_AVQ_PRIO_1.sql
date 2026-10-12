--==============================================================
-- Table: l_werbeflaechenthema_avq_prio_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenthema_avq_prio_1
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEFLAECHENTHEMA_AVQ_PRIO_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   werbeflaechenthema_avq_prio_nr      INTEGER     NOT NULL COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.',
   werbeflaechenthema_avq_prio_bez     VARCHAR(200)     COMMENT 'Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEFLAECHENTHEMA_AVQ_PRIO PRIMARY KEY (mandant_id, werbeflaechenthema_avq_prio_nr) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.';
