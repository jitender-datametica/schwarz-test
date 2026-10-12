CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_markant_1 (mandant_id, markant_id) AS SELECT mandant_id,
 markant_id
FROM kfl_production_dbp_view.v_l_markant_1
WHERE mandant_id = 1;