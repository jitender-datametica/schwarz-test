CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_werbemittel_promotion_event_zu_1 (mandant_id,
angebot_nr, werbemittel_id, werbemittelkanal_id, promotion_event_id, werbeflaechenabschnitt_name, werbemittel_bez,
werbemittelkanal_bez, werbethema_id, werbethema_bez, werbeflaechenthema_cd, werbeflaechenthema_bez, werbeposition_nr) AS
SELECT mandant_id,
 angebot_nr,
 werbemittel_id,
 werbemittelkanal_id,
 promotion_event_id,
 werbeflaechenabschnitt_name,
 werbemittel_bez,
 werbemittelkanal_bez,
 werbethema_id,
 werbethema_bez,
 werbeflaechenthema_cd,
 werbeflaechenthema_bez,
 werbeposition_nr
FROM kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu_1;