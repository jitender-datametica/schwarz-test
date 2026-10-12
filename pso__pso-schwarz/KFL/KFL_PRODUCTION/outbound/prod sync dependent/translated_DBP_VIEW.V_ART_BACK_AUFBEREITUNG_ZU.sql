CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_back_aufbereitung_zu (art_id, mandant_id, back_aufbereitung_id) AS
SELECT art_id,
 mandant_id,
 back_aufbereitung_id
FROM kfl_production_dbp_data.art_back_aufbereitung_zu;