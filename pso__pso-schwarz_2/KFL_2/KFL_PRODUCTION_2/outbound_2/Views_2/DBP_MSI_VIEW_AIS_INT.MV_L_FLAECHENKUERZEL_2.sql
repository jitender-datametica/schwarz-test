CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_flaechenkuerzel_2 (mandant_id, werbeflaechenthema_cd,
werbeflaechenthema_bez) AS SELECT V01.mandant_id,
 V02.werbeflaechenthema_cd,
 V01.werbeflaechenthema_bez
FROM kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu_2 AS V01
 LEFT JOIN kfl_production_dbp_data.promotion_event_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.promotion_event_id
     = V02.promotion_event_id AND V01.werbemittelkanal_id = V02.werbemittelkanal_id AND V01.werbeflaechenthema_cd = V02
   .werbeflaechenthema_cd
GROUP BY V01.mandant_id,
 V01.werbeflaechenthema_bez,
 V02.werbeflaechenthema_cd;