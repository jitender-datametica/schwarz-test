CREATE OR REPLACE VIEW kfl_production_dbp_view.v_predict_competitors_kaufland_zu_2 AS SELECT google_place_id,
 kjmo,
 mandant_id,
 wup_id,
 airline_distance
FROM kfl_production_dbp_data.predict_competitors_kaufland_zu_2;