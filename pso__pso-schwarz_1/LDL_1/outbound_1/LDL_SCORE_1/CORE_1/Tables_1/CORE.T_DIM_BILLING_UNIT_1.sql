--==============================================================
-- Table: t_dim_billing_unit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_billing_unit_1
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_billing_unit_1 (
billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
billing_unit_descr STRING(100) OPTIONS(description='Description of the Billing unit_1'),
billing_unit_descr_de STRING(100) OPTIONS(description='Description of the Billing unit_1 in German'),
billing_unit_descr_en STRING(100) OPTIONS(description='Description of the Billing unit_1 in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (billing_unit_cd) NOT ENFORCED
)
OPTIONS(description='Billing unit_1 minor dimension defines how pricing is applied and can be Pallets or Pallet Spaces etc. Billing unit_1 can be used as a biling measure for the price as well as unit_1 defining graduated scale.');