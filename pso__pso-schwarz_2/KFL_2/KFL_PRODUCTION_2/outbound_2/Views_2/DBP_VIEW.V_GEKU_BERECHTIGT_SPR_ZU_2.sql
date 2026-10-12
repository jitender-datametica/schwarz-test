CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_berechtigt_spr_zu_2 AS SELECT berechtigt_fg,
 spr_id,
 berechtigt_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_berechtigt_spr_zu_2;