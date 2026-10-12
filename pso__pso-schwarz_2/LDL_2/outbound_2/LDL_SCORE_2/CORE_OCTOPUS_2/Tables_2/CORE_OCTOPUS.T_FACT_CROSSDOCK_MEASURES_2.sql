CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_crossdock_measures_2 (
crossdock_sid BIGNUMERIC NOT NULL OPTIONS(description='Refering crossdock'),
operating_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='Hauler (Spediteur) who is running the crossdock'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
transport_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"'),
pallet_type_cd STRING(20) NOT NULL OPTIONS(description='Pallet code of the fact row'),
cal_dt DATE NOT NULL OPTIONS(description='Assigned date, in this case the concrete date at the crossdock'),
first_day_of_time_range_fg BOOL NOT NULL
OPTIONS(description='Indicates if this row is used for year to date calculations'),
day_accurate_delivery_fg BOOL NOT NULL
OPTIONS(description='Indicates if this row only containy day accurate delivery amounts'),
receiving_bus_country_cd STRING(2) NOT NULL OPTIONS(description='Business country_2 to which the good is dedicated to'),
pallet_cnt BIGNUMERIC OPTIONS(description='The total number of pallets that have been ordered.'),
adv_pallet_cnt BIGNUMERIC
OPTIONS(description='The number of pallets that have been ordered as part of an advertising campaign.'),
weighted_pallet_cnt BIGNUMERIC(38,5)
OPTIONS(description='The number of ordered pallets divided by the number of relevant days in the time range.'),
transport_storage_space_qty BIGNUMERIC(38,5) OPTIONS(description='Needed storage space due to transport services'),
transport_storage_space_weighted_qty BIGNUMERIC(38,5)
OPTIONS(description='Needed storage space due to transport services divided by the amount of relevant days within timerange'),
logistics_storage_space_qty BIGNUMERIC(38,5) OPTIONS(description='Needed storage space due to logistic services'),
logistics_storage_space_weighted_qty BIGNUMERIC(38,5)
OPTIONS(description='Needed storage space due to logistic services divided by the amount of relevant days within timerange'),
site_capacity_asis_qty BIGNUMERIC(38,5)
OPTIONS(description='Current capacacity for the crossdock, temperature zone combination at the moment'),
site_capacity_hist_qty BIGNUMERIC(38,5)
OPTIONS(description='Capacity for the crossdock, temperature zone combination at the assigned date'),
PRIMARY KEY (crossdock_sid, logistic_temp_cd, transport_service_type_cd, pallet_type_cd, cal_dt,
 first_day_of_time_range_fg, day_accurate_delivery_fg, receiving_bus_country_cd) NOT ENFORCED
)
OPTIONS(description='This factual table basically captures the capacities of crossdocks. It lists the crossdocks that are expecting a delivery. A delivery can either take place on a key date or over a period of time. Each delivery takes up a certain amount of pallet space and the current free space in the crossdock is indicated. ');