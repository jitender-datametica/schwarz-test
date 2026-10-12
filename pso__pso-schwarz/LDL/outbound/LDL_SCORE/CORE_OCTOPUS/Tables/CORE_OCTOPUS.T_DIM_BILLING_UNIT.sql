CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_billing_unit (
billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
billing_unit_descr STRING(100) OPTIONS(description='Description of the Billing unit'),
billing_unit_descr_de STRING(100) OPTIONS(description='Description of the Billing unit in German'),
billing_unit_descr_en STRING(100) OPTIONS(description='Description of the Billing unit in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (billing_unit_cd) NOT ENFORCED
)
OPTIONS(description='Billing unit minor dimension defines how pricing is applied and can be Pallets or Pallet Spaces etc. Billing unit can be used as a biling measure for the price as well as unit defining graduated scale.');