CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_0rt_promo_attr_2_promotion (
record_id INTEGER,
client_id BIGNUMERIC(38),
prom_sid BIGNUMERIC(38),
src_aktnr STRING(20),
prom_name STRING(100) COLLATE 'und:ci',
promotion_class_mark STRING(20),
promotion_class_label STRING(100) COLLATE 'und:ci',
promotion_type_mark STRING(20),
promotion_type_label STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);