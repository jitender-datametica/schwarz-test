CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_kfl_retail_store_mo_sum AS SELECT mandant_id,
 wup_id,
 nb_id,
 kjmo,
 anz_review_rating,
 sum_review_rating
FROM kfl_production_dbp_msi_data.kfl_retail_store_mo_sum;