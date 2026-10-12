CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeflaechenabschnitt_avq_prio (mandant_id
OPTIONS(description='Mandant im DWH.'), werbeflaechenabschnitt_avq_prio_nr
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.'),
werbeflaechenabschnitt_avq_prio_bez
OPTIONS(description='Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE PRIORISIERUNG DER ABVERKAUFSQUOTE (AVQ) IM KONTEXT DES WERBEFLÄCHENABSCHNITTS.`)
AS SELECT mandant_id,
 werbeflaechenabschnitt_avq_prio_nr,
 werbeflaechenabschnitt_avq_prio_bez
FROM kfl_production_dbp_data.l_werbeflaechenabschnitt_avq_prio;