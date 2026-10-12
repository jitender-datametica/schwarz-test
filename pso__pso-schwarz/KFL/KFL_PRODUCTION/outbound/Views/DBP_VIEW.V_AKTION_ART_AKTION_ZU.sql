CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktion_art_aktion_zu AS SELECT mandant_id,
 kl_art_id,
 plan_aktion_id,
 aktion_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.aktion_art_aktion_zu;