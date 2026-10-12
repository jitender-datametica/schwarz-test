--==============================================================
-- Table: t_fact_transport_cost_pallet_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_transport_cost_pallet_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:59:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TRANSPORT_COST_PALLET_2 (
   inbound_transport_plan_pos_sid      NUMBER          NOT NULL COMMENT 'new - unique identifier (surrogate key) of the transport plan position',
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   departure_site_sid                  NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   destination_site_sid                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   executing_hauler_sid                NUMBER          NOT NULL COMMENT 'The hauler who runs the crossdock.',
   logistic_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
   transport_service_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"',
   logistic_temp_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'A code for the pallet that indicates the storage occupation for transportation.',
   double_deck_fg                      BOOLEAN         COMMENT 'indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space',
   segment_agmt_elem_sid               NUMBER          COMMENT 'Surrogate identifier for Agreement element',
   logistics_tariff_sid                NUMBER          COMMENT 'Surrogate identifier for Logistics Tariff',
   supplier_curr_cd                    VARCHAR(3)      COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   supplier_transport_val              NUMBER(38, 5)   COMMENT 'Amount of money, which is paid from Supplier_2 to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty',
   hauler_curr_cd                      VARCHAR(3)      COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   hauler_transport_val                NUMBER(38, 5)   COMMENT 'Calculated Amount for each route, for each vehicle',
   transport_commission_val            NUMBER(38, 5)   COMMENT 'Difference between supplier_2 transport value and hauler transport value.',
   storage_space_qty                   NUMBER(38, 5)   COMMENT 'Needed storage space.',
   weight_ton_meas                     NUMBER(38, 5)   COMMENT 'which weight does total amout of pallets have',
   distance_km_meas                    NUMBER(38, 5)   COMMENT 'Distance of route segment in km',
   std_pallet_qty                      NUMBER(38, 5)   COMMENT 'Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.',
   case_cnt                            NUMBER          NOT NULL COMMENT 'The total number of cases in this position.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_FACT_TRANSPORT_COST_PALLET PRIMARY KEY (inbound_transport_plan_pos_sid, cal_dt) NOT ENFORCED 
)  COMMENT = 'This table decribes actual costs that were charged per pallet';
