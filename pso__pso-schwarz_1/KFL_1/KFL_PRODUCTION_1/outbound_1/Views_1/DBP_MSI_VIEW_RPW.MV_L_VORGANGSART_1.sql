CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_vorgangsart_1 (mandant_id, vorgangsart_id, system_id) AS
SELECT mandant_id,
 vorgangsart_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_vorgangsart_1
WHERE mandant_id = 1;