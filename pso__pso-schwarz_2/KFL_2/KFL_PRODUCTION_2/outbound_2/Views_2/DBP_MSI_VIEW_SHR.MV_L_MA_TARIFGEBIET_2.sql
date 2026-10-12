CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_ma_tarifgebiet_2 (mandant_id, tarifgebiet_id) AS SELECT
 mandant_id,
 tarifgebiet_id
FROM kfl_production_dbp_view.v_l_ma_tarifgebiet_2 AS V01;