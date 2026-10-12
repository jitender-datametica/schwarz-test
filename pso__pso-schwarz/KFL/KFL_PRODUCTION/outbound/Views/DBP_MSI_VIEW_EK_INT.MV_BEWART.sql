CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_bewart AS SELECT bewart_id
FROM kfl_production_dbp_view.v_bewart
WHERE bewart_id IN (1001, 1002);