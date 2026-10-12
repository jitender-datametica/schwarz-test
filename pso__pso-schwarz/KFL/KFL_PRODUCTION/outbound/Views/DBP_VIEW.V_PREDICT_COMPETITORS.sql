CREATE OR REPLACE VIEW kfl_production_dbp_view.v_predict_competitors AS SELECT google_place_id,
 mandant_id,
 competitor_name,
 wup_name,
 wup_str,
 wup_standort,
 laengengrad,
 breitengrad
FROM kfl_production_dbp_data.predict_competitors;