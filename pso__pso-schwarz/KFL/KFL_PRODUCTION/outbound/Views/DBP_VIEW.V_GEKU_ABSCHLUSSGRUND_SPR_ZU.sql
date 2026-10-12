CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_abschlussgrund_spr_zu AS SELECT abschlussgrund_id,
 spr_id,
 abschlussgrund_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_abschlussgrund_spr_zu;