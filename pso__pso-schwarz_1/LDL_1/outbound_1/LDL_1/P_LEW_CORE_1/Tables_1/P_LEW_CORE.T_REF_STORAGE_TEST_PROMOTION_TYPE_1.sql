/* --------------------------------------------------------------------------------
   DDL for table: t_ref_storage_test_promotion_type_1
   generated from Powerdesigner on Dienstag, 19. September 2023 16:51:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_storage_test_promotion_type_1 (
storage_test_promo_type_cd STRING(100) NOT NULL
OPTIONS(description='A code for promotional clusters used in storage tests (Normal, Promo).'),
storage_test_promo_type_descr STRING(250) NOT NULL
OPTIONS(description='A description for promotional clusters used in storage tests.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_promo_type_cd) NOT ENFORCED
)
OPTIONS(description='A reference table that contains definions of promotional clusters used in storage tests (Normal, Promo).             Source: FTM ( manual static mapping)');