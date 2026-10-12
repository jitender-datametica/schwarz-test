--==============================================================
-- Table: t_dim_logistics_tariff_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_logistics_tariff_1
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:41:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LOGISTICS_TARIFF_1 (
   logistics_tariff_sid                NUMBER          NOT NULL COMMENT 'Surrogate identifier for Logistics Tariff',
   equipment_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
   negot_fg                            BOOLEAN         COMMENT 'Is this a negotiable term?',
   weight_dispo_fg                     BOOLEAN         COMMENT 'There can be a weight disposition in the groupage load as well as in the full load. In groupage, for example, the wine logistics are ordered truck-specifically, 
            since there are many heavy items in the order and the truck does not necessarily have to be ordered with a minimum purchase of 33 pallets,
             but the weight restriction (e.g. 22.5 t) can also be reached first .
            ',
   max_tons_meas                       NUMBER(38, 5)   COMMENT 'The maximum allowance for charging a truck in tons',
   term_day_cnt                        NUMBER          COMMENT 'Term days',
   min_pallet_cnt                      NUMBER          COMMENT 'Minimum permitted load in Euro Pallets',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTICS_TARIFF PRIMARY KEY (logistics_tariff_sid) NOT ENFORCED 
)  COMMENT = 'Contains details about terms and conditions of tariffs applicable for a logistical agreements
             ';
