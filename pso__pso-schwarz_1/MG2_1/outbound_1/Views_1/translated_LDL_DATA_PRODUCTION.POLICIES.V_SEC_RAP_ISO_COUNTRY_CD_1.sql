CREATE OR REPLACE VIEW ldl_data_production_policies.v_sec_rap_iso_country_cd_1 (name, iso_country_cd) AS SELECT DISTINCT CAST(role_name AS STRING)
 AS name,
 CAST(iso_country_cd AS STRING) AS iso_country_cd
FROM ldl_data_production_policies.t_sec_rap_core_iso_country_cd_1;