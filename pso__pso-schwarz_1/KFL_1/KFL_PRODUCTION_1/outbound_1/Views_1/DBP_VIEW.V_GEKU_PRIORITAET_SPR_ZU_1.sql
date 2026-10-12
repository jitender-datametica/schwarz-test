CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_prioritaet_spr_zu_1 AS SELECT geku_prioritaet_id,
 spr_id,
 geku_prioritaet_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_prioritaet_spr_zu_1;