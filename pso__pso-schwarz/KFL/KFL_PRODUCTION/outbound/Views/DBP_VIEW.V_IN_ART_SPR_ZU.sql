CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_art_spr_zu AS SELECT in_art_id,
 spr_id,
 mandant_id,
 system_id,
 art_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_art_spr_zu;