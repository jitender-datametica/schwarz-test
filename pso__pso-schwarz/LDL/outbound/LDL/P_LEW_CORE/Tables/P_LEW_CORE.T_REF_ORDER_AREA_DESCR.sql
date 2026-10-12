CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_order_area_descr (
client_id BIGNUMERIC(38,0) NOT NULL,
order_area_cd STRING(5) NOT NULL,
lang_sid BIGNUMERIC(38,0) NOT NULL,
lang_cd STRING(2) NOT NULL,
order_area_descr STRING(100) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;