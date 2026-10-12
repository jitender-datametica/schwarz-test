CREATE TABLE CORE_REL_OCTOPUS.T_REF_BILLING_UNIT_2 (
   billing_unit_cd                     VARCHAR(20)     NOT NULL COMMENT 'This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.',
   billing_unit_descr                  VARCHAR(100)    COMMENT 'Description of the Billing unit_2',
   billing_unit_descr_de               VARCHAR(100)    COMMENT 'Description of the Billing unit_2 in German',
   billing_unit_descr_en               VARCHAR(100)    COMMENT 'Description of the Billing unit_2 in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_BILLING_UNIT PRIMARY KEY (billing_unit_cd) NOT ENFORCED 
)  COMMENT = 'Billing unit_2 component defines how pricing is applied and can be per Pallets, per Container, per Piece, per Storage Space, per Equipment. Billing unit_2 can be used as a biling measure for the price as well as unit_2 defining graduated scale.';
