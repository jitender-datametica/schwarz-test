/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pallet_type_2
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:48:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pallet_type_2 (
pallet_type_cd STRING(100) NOT NULL OPTIONS(description='Code for the pallet type, i.e. EP, DD, AE, etc.'),
pallet_type_descr STRING(250) NOT NULL OPTIONS(description='Description of the main pallet type.'),
pallet_type_factor BIGNUMERIC(38,5)
OPTIONS(description='Conversion factor of logical pallet to euro pallet equivalent.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (pallet_type_cd) NOT ENFORCED
)
OPTIONS(description='Table holds the pallet types, as well as the conversion factor to the equivalent euro pallet. Number of pallets * factor = number of pallets in terms of euro pallets.');