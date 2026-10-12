CREATE OR REPLACE VIEW kfl_production_dbp_view.v_predict_google_review_kaufland AS SELECT google_place_id,
 kjmo,
 mandant_id,
 wup_id,
 predict_review_count,
 predict_rating_avg
FROM kfl_production_dbp_data.predict_google_review_kaufland;