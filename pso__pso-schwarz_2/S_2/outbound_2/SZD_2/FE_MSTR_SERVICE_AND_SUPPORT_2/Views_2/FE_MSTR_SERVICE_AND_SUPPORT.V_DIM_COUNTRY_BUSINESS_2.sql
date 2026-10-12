CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_dim_country_business_2 (country_business_cd,
country_business_name) AS SELECT country_business_cd,
 country_business_name
FROM szd_core.t_dim_country_business_2
WHERE dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP);