CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_bq_findung_2 (mandant_id, bq_findung_id) AS SELECT
 mandant_id,
 bq_findung_id
FROM kfl_production_dbp_view.v_l_bq_findung_2 AS V01;