CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_grund_spr_zu_1 AS SELECT geku_grund_uid,
 spr_id,
 geku_grund_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_grund_spr_zu_1;