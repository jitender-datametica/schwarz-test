CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_bq_findung_spr_zu_2 (mandant_id, bq_findung_id, bq_findung_bez,
bq_findung_id_bez) AS SELECT mandant_id,
 bq_findung_id,
 bq_findung_bez,
   CAST(bq_findung_id AS STRING) || ' ' || bq_findung_bez AS bq_findung_id_bez
FROM kfl_production_dbp_view.v_bq_findung_spr_zu_2 AS V01
WHERE spr_id = 22
 AND mandant_id = 1;