CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_bereich_spr_zu AS SELECT geku_bereich_uid,
 spr_id,
 geku_bereich_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_bereich_spr_zu;