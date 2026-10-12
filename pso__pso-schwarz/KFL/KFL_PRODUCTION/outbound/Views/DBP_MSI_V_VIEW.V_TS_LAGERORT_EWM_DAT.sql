CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_lagerort_ewm_dat AS SELECT mandant_id,
 lagerort_id,
 lagernummer_id,
 wup_id,
 nb_id,
 dat
FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat;