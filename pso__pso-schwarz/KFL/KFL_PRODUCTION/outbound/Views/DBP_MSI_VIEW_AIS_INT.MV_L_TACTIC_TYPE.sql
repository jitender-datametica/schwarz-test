CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_tactic_type (mandant_id, werbemittelkanal_id,
werbemittelkanal_bez) AS SELECT V01.mandant_id,
 V02.werbemittelkanal_id,
 V01.werbemittelkanal_bez
FROM kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu AS V01
 INNER JOIN kfl_production_dbp_data.promotion_event AS V02 ON V01.mandant_id = V02.mandant_id AND V01.promotion_event_id
     = V02.promotion_event_id AND V01.werbemittelkanal_id = V02.werbemittelkanal_id
GROUP BY V01.mandant_id,
 V01.werbemittelkanal_bez,
 V02.werbemittelkanal_id;