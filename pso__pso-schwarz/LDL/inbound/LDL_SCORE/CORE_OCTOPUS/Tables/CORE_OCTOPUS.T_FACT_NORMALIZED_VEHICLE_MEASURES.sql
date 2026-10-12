CREATE TABLE CORE_OCTOPUS.T_FACT_NORMALIZED_VEHICLE_MEASURES (
   inbound_dispo_order_sid             NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the disposition.',
   transport_unit_seq                  NUMBER          COMMENT 'the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late',
   executing_hauler_sid                NUMBER          NOT NULL COMMENT 'The hauler who runs the crossdock.',
   receiving_wh_sid                    NUMBER          NOT NULL COMMENT 'Warehouse to which the good has to be delivered',
   main_crossdock_sid                  NUMBER          COMMENT 'Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types',
   supplier_site_sid                   NUMBER          COMMENT 'Supplier site where the goods are provided, for KoL (Komplettladung / Direktlogistik) logistic types',
   logistic_type_cd                    VARCHAR(20)     COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   logistic_temp_cd                    VARCHAR(20)     COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   bus_country_cd                      VARCHAR(2)      COMMENT 'Business country to which the good is dedicated to',
   means_of_transport_cd               VARCHAR(20)     COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)',
   cal_dt                              DATE            COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   transport_vehicle_descr             VARCHAR(100)    COMMENT 'Description of the transport vehicle. Contains the transport_vehicle_type_cd (LKW, WAGGON etc) + transport_capacity_qty + weight of the vehicle.  ',
   avg_vehicle_cnt                     NUMBER(38, 5)   COMMENT 'Amount of vehicles which are used to deliver the goods',   
   CONSTRAINT PK_T_FACT_NORMALIZED_VEHICLE_MEASURES PRIMARY KEY (inbound_dispo_order_sid, executing_hauler_sid) NOT ENFORCED 
)  COMMENT = 'Vehicle measures normalized on Vehicle';