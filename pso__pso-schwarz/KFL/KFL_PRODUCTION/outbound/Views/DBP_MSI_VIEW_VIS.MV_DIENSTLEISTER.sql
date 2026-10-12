CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_dienstleister (dienstleister_id) AS SELECT DISTINCT
 dienstleister_id
FROM kfl_production_dbp_data.l_dienstleister AS DL;