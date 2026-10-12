CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_werbeware AS SELECT werbeware_id
FROM kfl_production_dbp_view.v_l_werbeware AS V01
GROUP BY werbeware_id;