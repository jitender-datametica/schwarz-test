--==============================================================
-- Table: t_fact_crossdock_pallets_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_crossdock_pallets_1
   generated from Powerdesigner on Montag, 30. September 2024 13:18:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CROSSDOCK_PALLETS_1 (
   current_crossdock_sid               NUMBER          NOT NULL COMMENT 'The current crossdock where goods are at. ',
   current_crossdock_start_from_dt     DATE            NOT NULL COMMENT 'The earliest possible date of delivery to the current crossdock.',
   current_crossdock_start_to_dt       DATE            NOT NULL COMMENT 'The latest date of delivery to the current crossdock.',
   next_crossdock_sid                  NUMBER          NOT NULL COMMENT 'The goods that are going to be delivered to the next crossdock. One current crossdock can deliver to multiple next crossdocks.',
   next_crossdock_end_from_dt          DATE            NOT NULL COMMENT 'The earliest possible date of delivery to the next crossdock.',
   next_crossdock_end_to_dt            DATE            COMMENT 'The latest date of delivery to the next crossdock.',
   previous_crossdock_sid              NUMBER          NOT NULL COMMENT 'The crossdock where the goods come from. If current crossdock = previous crossdock, then -1. ',
   previous_crossdock_start_from_dt    DATE            COMMENT 'The earliest possible date of delivery to the previous crossdock.',
   previous_crossdock_start_to_dt      DATE            COMMENT 'The latest date of delivery to the previous crossdock.',
   bus_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'Business country_1 to which the good is dedicated to',
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   delivering_supplier_sid             NUMBER          NOT NULL COMMENT 'Supplier_1 who provides the goods',
   delivering_supplier_site_sid        NUMBER          NOT NULL COMMENT 'Site of the supplier_1 where the goods are provided',
   logistic_temp_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   logistic_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'Pallet code of the fact row',
   product_sid                         NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   product_variant_sid                 NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   receiving_wh_sid                    NUMBER          NOT NULL COMMENT 'Warehouse to which the good has to be delivered',
   pallet_cnt                          NUMBER          NOT NULL COMMENT 'The total number of pallets that have been ordered.',   
   CONSTRAINT PK_T_FACT_CROSSDOCK_PALLETS PRIMARY KEY (current_crossdock_sid, current_crossdock_start_from_dt, current_crossdock_start_to_dt, next_crossdock_sid, previous_crossdock_sid, cal_dt, delivering_supplier_site_sid, logistic_temp_cd, logistic_type_cd, pallet_type_cd, product_sid, receiving_wh_sid) NOT ENFORCED 
)  COMMENT = 'The focus is on the current crossdock and provides the information from which crossdock the products com from and where they go. 
             The number of pallets is also given. 
             Sometimes there is no previous crossdock for the current one specified, since this crossdock is the first one. 
             Same applies if the crossdock is the last one. This is marked with a -1.';
