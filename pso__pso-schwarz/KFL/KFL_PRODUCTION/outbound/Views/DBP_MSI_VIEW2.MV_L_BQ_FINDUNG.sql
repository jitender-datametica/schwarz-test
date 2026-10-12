CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_bq_findung (mandant_id, bq_findung_id) AS SELECT mandant_id,
 bq_findung_id
FROM kfl_production_dbp_view.v_l_bq_findung AS V01
WHERE mandant_id = 1;