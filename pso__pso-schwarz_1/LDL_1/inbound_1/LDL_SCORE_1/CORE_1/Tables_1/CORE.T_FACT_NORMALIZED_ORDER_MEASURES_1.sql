--==============================================================
-- Table: t_fact_normalized_order_measures_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_normalized_order_measures_1
   generated from Powerdesigner on Mittwoch, 9. Oktober 2024 14:55:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_NORMALIZED_ORDER_MEASURES_1 (
   delivering_supplier_sid             NUMBER          NOT NULL COMMENT 'Supplier_1 who provides the goods',
   delivering_supplier_site_sid        NUMBER          NOT NULL COMMENT 'Site of the supplier_1 where the goods are provided',
   main_crossdock_sid                  NUMBER          NOT NULL COMMENT 'Main crossdock over which the good is routed, for SaL (Sammelladung / Sammellogistik) logistic types',
   main_crossdock_operating_hauler_sid NUMBER          NOT NULL COMMENT 'Operating hauler of the main crossdock',
   receiving_wh_sid                    NUMBER          NOT NULL COMMENT 'Warehouse to which the good has to be delivered',
   product_sid                         NUMBER          NOT NULL COMMENT 'Delivered Product',
   product_variant_sid                 NUMBER          NOT NULL COMMENT 'Product variant which is delivered',
   bus_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'Business country_1 to which the good is dedicated to',
   logistic_temp_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   logistic_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   normalized_case_cnt                 NUMBER(38,5)   NOT NULL COMMENT 'The total number of cases in this position.',
   normalized_pallet_cnt               NUMBER(38,5)   NOT NULL COMMENT 'The number of pallets in this position.',
   normalized_volume_meas              NUMBER(38,5)   COMMENT 'The total volume in m3 occupied by this position. (This includes the volume of the goods plus the volume of the pallets.)',
   normalized_weight_meas              NUMBER(38,5)   COMMENT 'The total weight in kg of this position. (This includes the weight of the goods plus the pallet weight.)',   
   CONSTRAINT PK_T_FACT_NORMALIZED_ORDER_MEASURES PRIMARY KEY (delivering_supplier_site_sid, main_crossdock_sid, receiving_wh_sid, product_sid, product_variant_sid, logistic_temp_cd, logistic_type_cd, cal_dt) NOT ENFORCED 
)  COMMENT = 'Order measures normalized on pallet';