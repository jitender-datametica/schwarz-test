CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_orig_coupon_type_1 (
orig_coupon_type_sid INTEGER NOT NULL,
orig_coupon_type_descr STRING(100) NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (orig_coupon_type_sid) NOT ENFORCED
);