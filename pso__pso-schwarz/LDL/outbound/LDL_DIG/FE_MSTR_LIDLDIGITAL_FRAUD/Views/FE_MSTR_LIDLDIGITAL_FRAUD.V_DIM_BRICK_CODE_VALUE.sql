CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital_fraud.v_dim_brick_code_value (value_cd, value_descr, is_custom_fg) AS
SELECT *
FROM ldl_dig_fe_mstr_lidldigital.v_dim_brick_code_value;