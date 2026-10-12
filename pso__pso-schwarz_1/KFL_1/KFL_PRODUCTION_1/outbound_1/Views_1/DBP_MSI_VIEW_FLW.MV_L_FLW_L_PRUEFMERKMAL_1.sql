CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_pruefmerkmal_1 (mandant_id, werk_id, stp_merkmal_id) AS
SELECT mandant_id,
 werk_id,
 stp_merkmal_id
FROM kfl_production_dbp_view.v_flw_l_pruefmerkmal_1 AS V01;