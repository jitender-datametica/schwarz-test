CREATE TABLE CORE.T_FACT_VEHICLE_MEASURES (
   inbound_dispo_order_sid             NUMBER          NOT NULL COMMENT 'Dispo Order',
   transport_unit_seq                  NUMBER          NOT NULL COMMENT 'the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late',
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   receiving_wh_sid                    NUMBER          NOT NULL COMMENT 'Warehouse to which the good has to be delivered',
   executing_hauler_sid                NUMBER          NOT NULL COMMENT 'The hauler who runs the crossdock.',
   main_crossdock_sid                  NUMBER          NOT NULL COMMENT 'Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types',
   supplier_site_sid                   NUMBER          NOT NULL COMMENT 'Supplier site where the goods are provided, for KoL (Komplettladung / Direktlogistik)  logistic types',
   logistic_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   logistic_temp_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   means_of_transport_cd               VARCHAR(20)     NOT NULL COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)',
   bus_country_cd                      VARCHAR(2)      COMMENT 'Business country to which the good is dedicated to',
   planned_order_dt                    DATE            COMMENT 'A date when disposition supposed to be ordered, may differ from a date when disposition was really sent.',
   transport_vehicle_descr             VARCHAR(100)    COMMENT 'Description of the vehicle which is planned to deliver the goods',
   vehicle_cnt                         NUMBER          COMMENT 'Amount of vehicles which are used to deliver the goods',   
   CONSTRAINT PK_T_FACT_VEHICLE_MEASURES PRIMARY KEY (inbound_dispo_order_sid, transport_unit_seq, cal_dt, receiving_wh_sid, executing_hauler_sid, main_crossdock_sid, supplier_site_sid, logistic_type_cd, logistic_temp_cd, means_of_transport_cd) NOT ENFORCED 
)  COMMENT = 'This table lists the vehicles with which a disposition is executed. A disposition can be executed by a hauler via different means. This can be done by train, ship or truck. In addition, it is indicated how often a vehicle is used for a transport and how much load it can carry.   ';
