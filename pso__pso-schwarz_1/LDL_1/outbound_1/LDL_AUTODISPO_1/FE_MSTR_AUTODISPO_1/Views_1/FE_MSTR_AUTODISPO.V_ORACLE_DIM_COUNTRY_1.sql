CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_country_1 (country_1, source_flag, adl_active_flag) AS
SELECT country_1,
 MAX(source_flag) AS source_flag,
 MAX(adl_active_flag) AS adl_active_flag
FROM ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_warehouse_1
GROUP BY country_1;