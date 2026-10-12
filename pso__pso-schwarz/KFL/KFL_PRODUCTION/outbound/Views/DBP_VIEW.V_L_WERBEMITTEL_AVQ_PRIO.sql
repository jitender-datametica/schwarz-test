CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbemittel_avq_prio (mandant_id
OPTIONS(description='Mandant im DWH.'), werbemittel_avq_prio_nr
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.'),
werbemittel_avq_prio_bez
OPTIONS(description='Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbemittels.'))
OPTIONS(DESCRIPTION = `LOOKUP-TABELLE FÜR DIE PRIORISIERUNG DER ABVERKAUFSQUOTE (AVQ) IM KONTEXT DES WERBEMITTELS. `) AS
SELECT mandant_id,
 werbemittel_avq_prio_nr,
 werbemittel_avq_prio_bez
FROM kfl_production_dbp_data.l_werbemittel_avq_prio;