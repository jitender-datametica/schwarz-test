CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_teilbereich_2 (teilbereich_id, ber_id) AS SELECT CAST(teilbereich_id AS BIGNUMERIC)
 AS teilbereich_id,
 ber_id
FROM kfl_production_dbp_view.v_mcx_l_teilbereich_2;