--==============================================================
-- Table: t_fact_transport_surcharge_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_fact_transport_surcharge_1
   generated from Powerdesigner on Freitag, 19. Juli 2024 07:35:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TRANSPORT_SURCHARGE_1 (
   individual_logistics_agmt_elem_sid  NUMBER          NOT NULL COMMENT 'Surrogate identifier for agreement element',
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   surcharge_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'This is a code, which defines the services for which, a fee is charged.',
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'Pallet code of the fact row',
   pallet_exchange_fg                  BOOLEAN         NOT NULL COMMENT 'A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.',
   logistic_temp_cd                    VARCHAR(20)     COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   departure_site_sid                  NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   destination_site_sid                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   logistics_tariff_sid                NUMBER          COMMENT 'Surrogate identifier for Logistics Tariff',
   validity_period_from_tmsp           TIMESTAMP_TZ(9) NOT NULL COMMENT 'Validity_1 start of transport tariff',
   validity_period_to_tmsp             TIMESTAMP_TZ(9) NOT NULL COMMENT 'Validity_1 end of transport tariff',
   executing_hauler_sid                NUMBER          NOT NULL COMMENT 'The hauler who runs the crossdock.',
   price_billing_unit_cd               VARCHAR(20)     COMMENT 'This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   graduated_scale_billing_unit_cd     VARCHAR(20)     NOT NULL COMMENT 'This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   unit_from_cnt                       NUMBER          NOT NULL COMMENT 'Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit_1 record',
   unit_to_cnt                         NUMBER          NOT NULL COMMENT 'End of the range for  number of pallets or pallet spaces etc for this graduated scale unit_1 record',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   surcharge_val                       NUMBER(38, 5)   NOT NULL COMMENT 'Amount of all surcharges',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_FACT_TRANSPORT_SURCHARGE PRIMARY KEY (individual_logistics_agmt_elem_sid, cal_dt, pallet_type_cd, pallet_exchange_fg, surcharge_type_cd, departure_site_sid) NOT ENFORCED 
)  COMMENT = 'This table decribes list of transport surcharge prices.';
