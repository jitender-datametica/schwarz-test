CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBEFLAECHENTHEMA_AVQ_PRIO (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,werbeflaechenthema_avq_prio_nr           COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.'
  ,werbeflaechenthema_avq_prio_bez          COMMENT 'Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.'
)
COMMENT = 'Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.'
 AS 
    SELECT 
        mandant_id,
        werbeflaechenthema_avq_prio_nr,
        werbeflaechenthema_avq_prio_bez

FROM DBP_DATA.L_WERBEFLAECHENTHEMA_AVQ_PRIO ;