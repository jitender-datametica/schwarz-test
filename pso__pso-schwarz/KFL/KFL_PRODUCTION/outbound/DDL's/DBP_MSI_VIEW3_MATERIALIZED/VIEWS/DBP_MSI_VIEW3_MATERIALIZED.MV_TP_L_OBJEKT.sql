CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_tp_l_objekt (mandant_id, tp_objekt_id) AS SELECT
 mandant_id,
 tp_objekt_id
FROM kfl_production_dbp_view.v_tp_l_objekt AS V01;