CREATE OR REPLACE VIEW DBP_VIEW.V_L_WERBEMITTEL_AVQ_PRIO (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,werbemittel_avq_prio_nr                  COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.'
  ,werbemittel_avq_prio_bez                 COMMENT 'Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbemittels.'
)
COMMENT = 'Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbemittels. '
 AS 
    SELECT 
        mandant_id,
        werbemittel_avq_prio_nr,
        werbemittel_avq_prio_bez

FROM DBP_DATA.L_WERBEMITTEL_AVQ_PRIO ;