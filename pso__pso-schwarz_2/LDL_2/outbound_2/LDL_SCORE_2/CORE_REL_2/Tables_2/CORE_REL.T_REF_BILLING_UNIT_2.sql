--==============================================================
-- Table: t_ref_billing_unit_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_billing_unit_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_billing_unit_2 (
billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
billing_unit_descr STRING(100) OPTIONS(description='Description of the Billing unit_2'),
billing_unit_descr_de STRING(100) OPTIONS(description='Description of the Billing unit_2 in German'),
billing_unit_descr_en STRING(100) OPTIONS(description='Description of the Billing unit_2 in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (billing_unit_cd) NOT ENFORCED
)
OPTIONS(description='Billing unit_2 component defines how pricing is applied and can be per Pallets, per Container, per Piece, per Storage Space, per Equipment. Billing unit_2 can be used as a biling measure for the price as well as unit_2 defining graduated scale.');