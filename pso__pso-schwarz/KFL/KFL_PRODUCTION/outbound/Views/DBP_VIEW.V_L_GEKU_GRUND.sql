CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_grund AS SELECT geku_grund_uid,
 geku_grund_id,
 geku_bereich_uid,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_grund;