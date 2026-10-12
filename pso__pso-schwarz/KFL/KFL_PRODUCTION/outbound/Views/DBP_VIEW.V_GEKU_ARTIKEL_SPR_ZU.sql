CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_artikel_spr_zu AS SELECT geku_artikel_uid,
 spr_id,
 geku_artikel_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_artikel_spr_zu;