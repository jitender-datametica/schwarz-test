CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_discount_live (
client_id BIGNUMERIC(38,0),
discount_sid BIGNUMERIC(38,0),
src_discount_nr STRING(100) COLLATE 'und:ci',
src_posart STRING(1) COLLATE 'und:ci',
src_discount_pct NUMERIC(18,5),
discount_descr STRING(100) COLLATE 'und:ci',
first_appearance_dt DATE,
lidlplus_coupon_pattern_fg BOOL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);