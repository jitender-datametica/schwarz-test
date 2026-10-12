CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_dat_beladung AS SELECT mandant_id,
 dat_beladung,
 idx_beladung,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wbs_dat_beladung;