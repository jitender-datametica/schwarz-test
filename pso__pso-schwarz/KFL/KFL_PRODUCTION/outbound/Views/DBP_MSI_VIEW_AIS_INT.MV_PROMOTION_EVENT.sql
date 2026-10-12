CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_promotion_event (mandant_id, promotion_event_id,
dat_promotion_event_gueltig_von, dat_promotion_event_gueltig_bis, werbemittel_id, werbemittelkanal_id, werbethema_id,
werbeflaechenthema_cd) AS SELECT mandant_id,
 promotion_event_id,
 dat_promotion_event_gueltig_von,
 dat_promotion_event_gueltig_bis,
 werbemittel_id,
 werbemittelkanal_id,
 werbethema_id,
 werbeflaechenthema_cd
FROM kfl_production_dbp_data.promotion_event;