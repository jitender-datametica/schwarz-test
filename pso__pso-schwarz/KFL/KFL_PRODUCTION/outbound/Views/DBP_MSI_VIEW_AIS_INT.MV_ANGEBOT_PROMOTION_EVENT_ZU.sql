CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_angebot_promotion_event_zu (mandant_id, angebot_nr,
promotion_event_id) AS SELECT mandant_id,
 angebot_nr,
 promotion_event_id
FROM kfl_production_dbp_data.angebot_promotion_event_zu;