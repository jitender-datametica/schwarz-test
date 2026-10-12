CREATE TABLE IF NOT EXISTS ldl_score_fe_mstr_score.t_fact_normalized_vehicle_measures (
inbound_dispo_order_sid BIGNUMERIC(38,0),
transport_unit_seq BIGNUMERIC(38,0),
executing_hauler_sid BIGNUMERIC(38,0),
receiving_wh_sid BIGNUMERIC(38,0),
main_crossdock_sid BIGNUMERIC(38,0),
supplier_site_sid BIGNUMERIC(38,0),
logistic_type_cd STRING(4),
logistic_temp_cd STRING(2),
bus_country_cd STRING(2),
means_of_transport_cd STRING(20),
cal_dt DATE,
transport_vehicle_descr STRING(100),
avg_vehicle_count BIGNUMERIC(38,5)
);