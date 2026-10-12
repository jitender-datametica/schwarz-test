CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_ma_tarifgebiet (mandant_id, tarifgebiet_id) AS SELECT *
FROM kfl_production_dbp_view.v_l_ma_tarifgebiet AS v01;