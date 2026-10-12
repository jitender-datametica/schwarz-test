CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_order_measures_1 (
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
main_crossdock_sid BIGNUMERIC NOT NULL
OPTIONS(description='Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types'),
main_crossdock_operating_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='Operating hauler of the main crossdock'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
bus_country_cd STRING(2) NOT NULL OPTIONS(description='Business country_1 to which the good is dedicated to'),
receiving_wh_sid BIGNUMERIC NOT NULL OPTIONS(description='Warehouse to which the good has to be delivered'),
delivering_supplier_sid BIGNUMERIC NOT NULL OPTIONS(description='Supplier_1 who provides the goods'),
delivering_supplier_site_sid BIGNUMERIC NOT NULL
OPTIONS(description='Site of the supplier_1 where the goods are provided'),
product_sid BIGNUMERIC NOT NULL OPTIONS(description='Delivered Product'),
product_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Product variant which is delivered'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
missing_reason_cd STRING(20) NOT NULL
OPTIONS(description='A code defining why a (part of) a dispo order position was declared as being missing'),
pallet_type_cd STRING(20) NOT NULL OPTIONS(description='Pallet code of the fact row'),
double_deck_fg BOOL NOT NULL OPTIONS(description='Indicates whether two pallets can be placed on top of each other.'),
case_cnt BIGNUMERIC NOT NULL OPTIONS(description='The total number of cases in this position.'),
pallet_cnt BIGNUMERIC NOT NULL OPTIONS(description='The number of pallets in this position.'),
std_pallet_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.'),
missing_pallet_cnt BIGNUMERIC NOT NULL OPTIONS(description='Quantity of pallets which were not delivered'),
volume_meas BIGNUMERIC(38,5)
OPTIONS(description='The total volume in m3 occupied by this position. (This includes the volume of the goods plus the volume of the pallets.)'),
weight_meas BIGNUMERIC(38,5)
OPTIONS(description='The total weight in kg of this position. (This includes the weight of the goods plus the pallet weight.)'),
PRIMARY KEY (delivering_supplier_site_sid, main_crossdock_sid, executing_hauler_sid, receiving_wh_sid, product_sid,
 product_variant_sid, logistic_temp_cd, logistic_type_cd, missing_reason_cd, pallet_type_cd, double_deck_fg, cal_dt)
NOT ENFORCED
)
OPTIONS(description='This table records all deliveries to a crossdock. A crossdock is supplied by a hauler. The products are listed and the logistic type (Sammelladung & Komplettladung) and the temperature zone. Furthermore, the reason why a product has not arrived or is delayed is also given. ');