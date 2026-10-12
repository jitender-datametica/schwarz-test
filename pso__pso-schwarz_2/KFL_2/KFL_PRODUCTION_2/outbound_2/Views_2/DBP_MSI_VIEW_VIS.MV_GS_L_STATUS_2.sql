CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_l_status_2 AS SELECT mandant_id,
 transaktion_id
FROM kfl_production_dbp_view.v_l_transaktion_2 AS V01
WHERE transaktion_id <> 18;