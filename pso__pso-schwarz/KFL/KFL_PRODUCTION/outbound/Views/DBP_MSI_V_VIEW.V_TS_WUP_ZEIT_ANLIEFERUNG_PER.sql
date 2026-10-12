CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wup_zeit_anlieferung_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 transportsortiment_id,
 dat_von,
 dat_bis,
 zeit_anlieferung,
 zeit_anlieferung_num
FROM kfl_production_dbp_msi_data.ts_wup_zeit_anlieferung_per;