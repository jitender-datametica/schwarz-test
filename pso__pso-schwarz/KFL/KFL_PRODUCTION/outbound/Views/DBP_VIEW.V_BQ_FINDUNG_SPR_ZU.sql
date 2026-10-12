CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bq_findung_spr_zu AS SELECT mandant_id,
 bq_findung_id,
 spr_id,
 bq_findung_bez
FROM kfl_production_dbp_data.bq_findung_spr_zu;