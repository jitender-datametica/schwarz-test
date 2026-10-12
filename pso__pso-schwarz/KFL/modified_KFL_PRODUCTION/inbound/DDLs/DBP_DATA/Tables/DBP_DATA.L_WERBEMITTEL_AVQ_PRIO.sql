--==============================================================
-- Table: l_werbemittel_avq_prio
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbemittel_avq_prio
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEMITTEL_AVQ_PRIO (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   werbemittel_avq_prio_nr             INTEGER     NOT NULL COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.',
   werbemittel_avq_prio_bez            VARCHAR(200)     COMMENT 'Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbemittels.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEMITTEL_AVQ_PRIO PRIMARY KEY (mandant_id, werbemittel_avq_prio_nr) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbemittels. ';
