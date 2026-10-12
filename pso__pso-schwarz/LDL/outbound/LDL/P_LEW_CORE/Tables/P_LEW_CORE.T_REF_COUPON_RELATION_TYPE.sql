/* --------------------------------------------------------------------------------
   DDL for table: t_ref_coupon_relation_type
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_coupon_relation_type (
coupon_relation_type_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the relation type, i.e. how something is related to the coupon'),
coupon_relation_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='description of the relation type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='$Revision: 0000 $. This minor entity describes how anything (e.g. item / store) is related to the coupon, e.g. a store might accept the coupon, or the price of an item is reduced by the coupon, ...');