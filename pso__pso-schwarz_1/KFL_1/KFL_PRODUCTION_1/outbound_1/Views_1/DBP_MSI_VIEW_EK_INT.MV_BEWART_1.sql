CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_bewart_1 AS SELECT bewart_id
FROM kfl_production_dbp_view.v_bewart_1
WHERE bewart_id IN (1001, 1002);