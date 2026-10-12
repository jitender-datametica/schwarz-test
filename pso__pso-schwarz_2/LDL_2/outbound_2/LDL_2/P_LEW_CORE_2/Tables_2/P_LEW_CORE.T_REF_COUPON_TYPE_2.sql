/* --------------------------------------------------------------------------------
   DDL for table: t_ref_coupon_type_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_coupon_type_2 (
coupon_type_cd STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='unique code identifying the type of the coupon, e.g. Welcome-Coupon, Goodwill-Coupon, etc.'),
coupon_type_short_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='short description of the coupon type'),
coupon_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='detailed description of the coupon type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='$Revision: 0000 $. This minor entity describes the type of the coupon, like Welcome, Weekly, Goodwill, ...');