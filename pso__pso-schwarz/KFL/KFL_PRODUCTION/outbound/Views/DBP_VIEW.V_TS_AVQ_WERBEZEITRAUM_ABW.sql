CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ts_avq_werbezeitraum_abw AS SELECT mandant_id,
 werbe_typ_id,
 dat_von,
 dat_bis,
 kommentar
FROM kfl_production_dbp_data.ts_avq_werbezeitraum_abw;