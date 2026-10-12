CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_risikoklasse_spr_zu_2 AS SELECT geku_risikoklasse_id,
 spr_id,
 geku_risikoklasse_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_risikoklasse_spr_zu_2;