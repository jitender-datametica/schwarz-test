CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_coupon_promotion_type_1 (
coupon_promo_type_sid INTEGER NOT NULL,
coupon_promo_type_descr STRING(100) NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (coupon_promo_type_sid) NOT ENFORCED
);