CREATE TABLE IF NOT EXISTS ldl_score_fe_mstr_score.t_fact_normalized_order_measures_2 (
delivering_supplier_sid BIGNUMERIC(38,0),
delivering_supplier_site_sid BIGNUMERIC(38,0),
main_crossdock_sid BIGNUMERIC(38,0),
main_crossdock_operating_hauler_sid BIGNUMERIC(38,0),
receiving_wh_sid BIGNUMERIC(38,0),
product_sid BIGNUMERIC(38,0),
product_variant_sid BIGNUMERIC(38,0),
bus_country_cd STRING(2),
logistic_temp_cd STRING(2),
logistic_type_cd STRING(4),
cal_dt DATE,
normalized_pallet_cnt BIGNUMERIC(38,5),
normalized_case_cnt BIGNUMERIC(38,5),
normalized_volume_meas BIGNUMERIC(38,5),
normalized_weight_meas BIGNUMERIC(38,5)
);