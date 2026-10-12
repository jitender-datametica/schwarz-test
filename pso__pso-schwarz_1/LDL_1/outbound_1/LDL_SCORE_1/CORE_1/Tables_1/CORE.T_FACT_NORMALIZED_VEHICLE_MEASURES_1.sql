--==============================================================
-- Table: t_fact_normalized_vehicle_measures_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_normalized_vehicle_measures_1
   generated from Powerdesigner on Mittwoch, 9. Oktober 2024 20:10:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_fact_normalized_vehicle_measures_1 (
inbound_dispo_order_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition.'),
transport_unit_seq BIGNUMERIC
OPTIONS(description='the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
receiving_wh_sid BIGNUMERIC NOT NULL OPTIONS(description='Warehouse to which the good has to be delivered'),
main_crossdock_sid BIGNUMERIC
OPTIONS(description='Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types'),
supplier_site_sid BIGNUMERIC
OPTIONS(description='Supplier_1 site where the goods are provided, for KoL (Komplettladung / Direktlogistik) logistic types'),
logistic_type_cd STRING(20)
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
logistic_temp_cd STRING(20) OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
bus_country_cd STRING(2) OPTIONS(description='Business country_1 to which the good is dedicated to'),
means_of_transport_cd STRING(20)
OPTIONS(description='Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'),
cal_dt DATE
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
transport_vehicle_descr STRING(100)
OPTIONS(description='Description of the transport vehicle. Contains the transport_vehicle_type_cd (LKW, WAGGON etc) + transport_capacity_qty + weight of the vehicle.  '),
avg_vehicle_cnt BIGNUMERIC(38,5) OPTIONS(description='Amount of vehicles which are used to deliver the goods'),
PRIMARY KEY (inbound_dispo_order_sid, executing_hauler_sid) NOT ENFORCED
) OPTIONS(description='Vehicle measures normalized on Vehicle');