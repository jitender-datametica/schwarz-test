CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_prioritaet_1 (geku_prioritaet_id, geku_risikoklasse_id, td_update
, td_insert) AS SELECT geku_prioritaet_id,
 geku_risikoklasse_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_prioritaet_1;