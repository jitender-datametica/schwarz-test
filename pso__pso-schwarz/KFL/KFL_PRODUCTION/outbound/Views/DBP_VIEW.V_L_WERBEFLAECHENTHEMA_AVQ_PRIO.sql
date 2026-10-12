CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeflaechenthema_avq_prio (mandant_id
OPTIONS(description='Mandant im DWH.'), werbeflaechenthema_avq_prio_nr
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.'),
werbeflaechenthema_avq_prio_bez
OPTIONS(description='Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE PRIORISIERUNG DER ABVERKAUFSQUOTE (AVQ) IM KONTEXT DES WERBEFLÄCHENTHEMAS.`)
AS SELECT mandant_id,
 werbeflaechenthema_avq_prio_nr,
 werbeflaechenthema_avq_prio_bez
FROM kfl_production_dbp_data.l_werbeflaechenthema_avq_prio;