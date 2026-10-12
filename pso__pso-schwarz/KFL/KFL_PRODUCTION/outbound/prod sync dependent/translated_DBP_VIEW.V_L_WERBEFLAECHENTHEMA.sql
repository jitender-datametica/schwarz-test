CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_werbeflaechenthema (mandant_id OPTIONS(description='Mandant im DWH.'),
werbemittelkanal_id OPTIONS(description='ID des Werbemittelkanals'), werbemittel_id
OPTIONS(description='ID des Werbemittels'), werbeflaechenthema_cd OPTIONS(description='Code des Werbeflaechenthemas'),
werbeflaechenthema_bez OPTIONS(description='Bezeichnung des Werbeflaechenthemas'), werbeflaechenthema_wfl_bez
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird. '),
werbeflaechenthema_avq_prio_nr
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.'))
AS SELECT mandant_id,
 werbemittelkanal_id,
 werbemittel_id,
 werbeflaechenthema_cd,
 werbeflaechenthema_bez,
 werbeflaechenthema_wfl_bez,
 werbeflaechenthema_avq_prio_nr
FROM kfl_production_dbp_data.l_werbeflaechenthema;