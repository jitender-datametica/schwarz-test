CREATE TABLE CORE_OCTOPUS.T_DIM_BILLING_UNIT_1 (
   billing_unit_cd                     VARCHAR(20)     NOT NULL COMMENT 'This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   billing_unit_descr                  VARCHAR(100)    COMMENT 'Description of the Billing unit_1',
   billing_unit_descr_de               VARCHAR(100)    COMMENT 'Description of the Billing unit_1 in German',
   billing_unit_descr_en               VARCHAR(100)    COMMENT 'Description of the Billing unit_1 in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_BILLING_UNIT PRIMARY KEY (billing_unit_cd) NOT ENFORCED 
)  COMMENT = 'Billing unit_1 minor dimension defines how pricing is applied and can be Pallets or Pallet Spaces etc. Billing unit_1 can be used as a biling measure for the price as well as unit_1 defining graduated scale.';
