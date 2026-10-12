CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_vehicle_measures_1 (
inbound_dispo_order_sid BIGNUMERIC NOT NULL OPTIONS(description='Dispo Order'),
transport_unit_seq BIGNUMERIC
OPTIONS(description='the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late'),
cal_dt DATE
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
receiving_wh_sid BIGNUMERIC OPTIONS(description='Warehouse to which the good has to be delivered'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
main_crossdock_sid BIGNUMERIC
OPTIONS(description='Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types'),
supplier_site_sid BIGNUMERIC
OPTIONS(description='Supplier_1 site where the goods are provided, for KoL (Komplettladung / Direktlogistik)  logistic types'),
logistic_type_cd STRING(20)
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
logistic_temp_cd STRING(20) OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
bus_country_cd STRING(2) OPTIONS(description='Business country_1 to which the good is dedicated to'),
means_of_transport_cd STRING(20)
OPTIONS(description='Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'),
transport_vehicle_descr STRING(100)
OPTIONS(description='Description of the vehicle which is planned to deliver the goods'),
vehicle_cnt BIGNUMERIC OPTIONS(description='Amount of vehicles which are used to deliver the goods'),
PRIMARY KEY (inbound_dispo_order_sid, executing_hauler_sid) NOT ENFORCED
)
OPTIONS(description='This table lists the vehicles with which a disposition is executed. A disposition can be executed by a hauler via different means. This can be done by train, ship or truck. In addition, it is indicated how often a vehicle is used for a transport and how much load it can carry.   ');