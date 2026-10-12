CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_spr_zu_1 AS SELECT mandant_id,
 art_id,
 spr_id,
 art_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_spr_zu_1;