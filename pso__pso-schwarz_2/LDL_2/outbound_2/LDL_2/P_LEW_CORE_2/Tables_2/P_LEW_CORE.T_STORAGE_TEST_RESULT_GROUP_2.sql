/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_result_group_2
   generated from Powerdesigner on Dienstag, 19. September 2023 17:18:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_result_group_2 (
storage_test_result_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key for result grouping.'),
storage_test_result_grp_type_cd STRING(100) NOT NULL
OPTIONS(description='A code for the type of grouping used in storage test_2 results (general, store, user defined group, product group).'),
loc_sid_store BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender / Mandanten hinweg).'),
test_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Week number in which a test_2 is conducted.'),
item_grp_int_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEMGROUP_2 INTERNATIONAL.'),
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUBITEMGROUP.'),
storage_test_promo_type_cd STRING(100) NOT NULL
OPTIONS(description='A code for promotional clusters used in storage tests (Normal, Promo).'),
user_defined_grp_name STRING(100) OPTIONS(description='A user defined group name.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_result_grp_sid) NOT ENFORCED
)
OPTIONS(description='A table to store different levels on which KPI are calculated in the storage tests. If an attribute is null it is not relevant for the given level.');