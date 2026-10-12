--==============================================================
-- Table: t_fact_normalized_order_measures_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_normalized_order_measures_2
   generated from Powerdesigner on Mittwoch, 9. Oktober 2024 14:55:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_fact_normalized_order_measures_2 (
delivering_supplier_sid BIGNUMERIC NOT NULL OPTIONS(description='Supplier_2 who provides the goods'),
delivering_supplier_site_sid BIGNUMERIC NOT NULL
OPTIONS(description='Site of the supplier_2 where the goods are provided'),
main_crossdock_sid BIGNUMERIC NOT NULL
OPTIONS(description='Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types'),
main_crossdock_operating_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='Operating hauler of the main crossdock'),
receiving_wh_sid BIGNUMERIC NOT NULL OPTIONS(description='Warehouse to which the good has to be delivered'),
product_sid BIGNUMERIC NOT NULL OPTIONS(description='Delivered Product'),
product_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Product variant which is delivered'),
bus_country_cd STRING(2) NOT NULL OPTIONS(description='Business country_2 to which the good is dedicated to'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
normalized_case_cnt BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The total number of cases in this position.'),
normalized_pallet_cnt BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The number of pallets in this position.'),
normalized_volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The total volume in m3 occupied by this position. (This includes the volume of the goods plus the volume of the pallets.)'),
normalized_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The total weight in kg of this position. (This includes the weight of the goods plus the pallet weight.)'),
PRIMARY KEY (delivering_supplier_site_sid, main_crossdock_sid, receiving_wh_sid, product_sid, product_variant_sid,
 logistic_temp_cd, logistic_type_cd, cal_dt) NOT ENFORCED
) OPTIONS(description='Order measures normalized on pallet');