CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_iwt_1 (mandant_id, iwt_id) AS SELECT mandant_id,
 iwt_id
FROM kfl_production_dbp_view.v_l_iwt_1 AS V01;