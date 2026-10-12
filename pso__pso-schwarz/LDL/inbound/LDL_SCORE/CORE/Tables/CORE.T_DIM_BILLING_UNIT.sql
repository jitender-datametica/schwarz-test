--==============================================================
-- Table: t_dim_billing_unit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_billing_unit
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_BILLING_UNIT (
   billing_unit_cd                     VARCHAR(20)      NOT NULL COMMENT 'This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   billing_unit_descr                  VARCHAR(100)     COMMENT 'Description of the Billing unit',
   billing_unit_descr_de               VARCHAR(100)     COMMENT 'Description of the Billing unit in German',
   billing_unit_descr_en               VARCHAR(100)     COMMENT 'Description of the Billing unit in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_BILLING_UNIT PRIMARY KEY (billing_unit_cd) NOT ENFORCED 
)  COMMENT = 'Billing unit minor dimension defines how pricing is applied and can be Pallets or Pallet Spaces etc. Billing unit can be used as a biling measure for the price as well as unit defining graduated scale.';

