CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbl_1 AS SELECT wbl_id,
 mandant_id,
 wbl_dat_von,
 wbl_name,
 gf_id,
 ek_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wbl_1;