CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0rt_promo_attr_2_promotion_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
rt_promo_attr_aktnr STRING(20),
src_aktnr STRING(20),
prom_name STRING(100) COLLATE 'und:ci',
promotion_class_mark STRING(20),
promotion_class_label STRING(100) COLLATE 'und:ci',
promotion_type_mark STRING(20),
promotion_type_label STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);