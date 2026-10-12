CREATE OR REPLACE VIEW szd_fe_mstr_service_and_support.v_dim_country_business (country_business_cd,
country_business_name) AS SELECT country_business_cd,
 country_business_name
FROM szd_core.t_dim_country_business
WHERE dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP);