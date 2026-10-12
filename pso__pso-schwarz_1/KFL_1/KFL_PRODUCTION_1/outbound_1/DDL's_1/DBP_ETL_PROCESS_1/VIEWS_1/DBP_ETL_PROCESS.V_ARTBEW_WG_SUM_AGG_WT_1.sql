CREATE OR REPLACE VIEW kfl_production_dbp_etl_process.v_artbew_wg_sum_agg_wt_1 (mandant_id, wup_id, nb_id, dat, calc_fg,
dat_lief, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_process.artbew_wg_sum_agg_wt_1;