CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_discount (
client_id BIGNUMERIC(38,0) NOT NULL,
discount_sid BIGNUMERIC(38,0) NOT NULL,
src_discount_nr STRING(100) COLLATE 'und:ci' NOT NULL,
src_posart STRING(1) COLLATE 'und:ci' NOT NULL,
src_discount_pct NUMERIC(18,5) NOT NULL,
discount_descr STRING(100) COLLATE 'und:ci',
first_appearance_dt DATE NOT NULL,
lidlplus_coupon_pattern_fg BOOL DEFAULT FALSE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (discount_sid) NOT ENFORCED
) CLUSTER BY client_id;