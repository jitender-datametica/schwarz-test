--==============================================================
-- Table: t_fact_transport_price_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_transport_price_2
   generated from Powerdesigner on Dienstag, 19. November 2024 16:35:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TRANSPORT_PRICE_2 (
   individual_logistics_agmt_elem_sid  NUMBER          NOT NULL COMMENT 'Surrogate identifier for agreement element',
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   transport_charge_type_cd            VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the services for which, a fee is charged.',
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'Pallet code of the fact row',
   pallet_exchange_fg                  BOOLEAN         NOT NULL COMMENT 'A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.',
   departure_site_sid                  NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   destination_site_sid                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   transport_service_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"',
   validity_period_from_tmsp           TIMESTAMP_TZ(9) NOT NULL COMMENT 'Validity_2 start of transport tariff',
   validity_period_to_tmsp             TIMESTAMP_TZ(9) NOT NULL COMMENT 'Validity_2 end of transport tariff',
   logistic_temp_cd                    VARCHAR(20)     COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   executing_hauler_sid                NUMBER          NOT NULL COMMENT 'The hauler who runs the crossdock.',
   logistics_tariff_sid                NUMBER          COMMENT 'Surrogate identifier for Logistics Tariff',
   price_billing_unit_cd               VARCHAR(20)     COMMENT 'This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   graduated_scale_billing_unit_cd     VARCHAR(20)     NOT NULL COMMENT 'This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   unit_from_cnt                       NUMBER          NOT NULL COMMENT 'Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit_2 record',
   unit_to_cnt                         NUMBER          NOT NULL COMMENT 'End of the range for  number of pallets or pallet spaces etc for this graduated scale unit_2 record',
   supplier_curr_cd                    VARCHAR(3)      COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   supplier_transport_val              NUMBER(38, 5)   COMMENT 'Amount of money, which is paid from Supplier_2 to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty',
   hauler_curr_cd                      VARCHAR(3)      COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   hauler_transport_val                NUMBER(38, 5)   COMMENT 'Calculated Amount for each route, for each vehicle',
   transport_commission_val            NUMBER(38, 5)   COMMENT 'Difference between supplier_2 transport value and hauler transport value.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_FACT_TRANSPORT_PRICE PRIMARY KEY (individual_logistics_agmt_elem_sid, cal_dt, transport_charge_type_cd, pallet_type_cd, pallet_exchange_fg, departure_site_sid, destination_site_sid, transport_service_type_cd, unit_from_cnt) NOT ENFORCED 
)  COMMENT = 'This table decribes list of transport prices valid for each day';
