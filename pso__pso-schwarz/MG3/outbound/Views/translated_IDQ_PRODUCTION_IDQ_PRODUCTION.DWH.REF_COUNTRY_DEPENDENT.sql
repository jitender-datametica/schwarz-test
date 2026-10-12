CREATE OR REPLACE VIEW idq_production_dwh.ref_country_dependent (dependent_ref_country_id, dependent_country,
dependent_country_name, dependent_country_name_de, dependent_country_name_en, dependent_capital, dependent_capital_de,
dependent_capital_en, dependent_hq_city, dependent_hq_city_de, dependent_hq_city_en, dependent_country_middle_longitude
, dependent_country_middle_latitude, dependent_hq_city_longitude, dependent_hq_city_latitude) AS SELECT id AS
 dependent_ref_country_id,
 country AS dependent_country,
 name_de AS dependent_country_name,
 name_de AS dependent_country_name_de,
 name_en AS dependent_country_name_en,
 capital_de AS dependent_capital,
 capital_de AS dependent_capital_de,
 capital_en AS dependent_capital_en,
 hq_city_de AS dependent_hq_city,
 hq_city_de AS dependent_hq_city_de,
 hq_city_en AS dependent_hq_city_en,
 country_middle_longitude AS dependent_country_middle_longitude,
 country_middle_latitude AS dependent_country_middle_latitude,
 hq_city_longitude AS dependent_hq_city_longitude,
 hq_city_latitude AS dependent_hq_city_latitude
FROM idq_production_idq_results.ref_country;