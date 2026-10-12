CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gf AS SELECT gf_id,
 mandant_id,
 ek_fg,
 gf_name,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gf;