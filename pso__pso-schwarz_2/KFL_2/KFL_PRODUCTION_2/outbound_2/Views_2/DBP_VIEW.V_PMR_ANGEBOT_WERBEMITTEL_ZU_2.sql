CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pmr_angebot_werbemittel_zu_2 AS SELECT mandant_id,
 angebot_id,
 werbemittel_art_id,
 werbemittel_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.pmr_angebot_werbemittel_zu_2;