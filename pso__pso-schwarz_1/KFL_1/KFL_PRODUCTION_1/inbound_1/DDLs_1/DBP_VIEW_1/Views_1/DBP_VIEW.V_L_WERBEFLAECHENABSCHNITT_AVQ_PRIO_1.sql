CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBEFLAECHENABSCHNITT_AVQ_PRIO_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,werbeflaechenabschnitt_avq_prio_nr       COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.'
  ,werbeflaechenabschnitt_avq_prio_bez      COMMENT 'Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.'
)
COMMENT = 'Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.'
 AS 
    SELECT 
        mandant_id,
        werbeflaechenabschnitt_avq_prio_nr,
        werbeflaechenabschnitt_avq_prio_bez

FROM DBP_DATA.L_WERBEFLAECHENABSCHNITT_AVQ_PRIO_1 ;