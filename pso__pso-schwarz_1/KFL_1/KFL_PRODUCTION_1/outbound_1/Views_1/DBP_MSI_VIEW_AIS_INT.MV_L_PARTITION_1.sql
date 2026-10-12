CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_partition_1 (mandant_id, werbeflaechenabschnitt_name) AS
SELECT V01.mandant_id,
 V01.werbeflaechenabschnitt_name
FROM kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu_1 AS V01
 LEFT JOIN kfl_production_dbp_data.promotion_event_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.promotion_event_id
     = V02.promotion_event_id AND V01.werbemittelkanal_id = V02.werbemittelkanal_id AND V01.werbemittel_id = V02.werbemittel_id
   
GROUP BY V01.mandant_id,
 V01.werbeflaechenabschnitt_name;