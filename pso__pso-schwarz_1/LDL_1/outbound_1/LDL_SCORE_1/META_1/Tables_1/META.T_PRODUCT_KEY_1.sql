CREATE TABLE IF NOT EXISTS ldl_score_meta.t_product_key_1 (
product_sid BIGNUMERIC(38,0) NOT NULL,
product_type_cd STRING(100) NOT NULL,
dwh_valid_from_tmsp DATETIME DEFAULT CAST('1900-01-01 00:00:00' AS DATETIME) NOT NULL,
dwh_valid_to_tmsp DATETIME DEFAULT CAST('9999-12-31 23:59:59' AS DATETIME) NOT NULL,
nat_key_comp_1_nr STRING(100) DEFAULT '@' NOT NULL,
nat_key_comp_2_nr STRING(100) DEFAULT '@' NOT NULL,
nat_key_comp_3_nr STRING(100) DEFAULT '@' NOT NULL
);