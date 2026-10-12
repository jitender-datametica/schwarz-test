/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_consolidated_promotion_item_type_1
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:18:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_consolidated_promotion_item_type_1 (
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item_1 should be regarded as a promotion item_1 or not.            "PN" = item_1 is a promotion item_1            "SO" = item_1 is not a promotion item_1            "no typification" = item_1 is not receiving a type (for LDL, only KFL items get a type)'),
kfl_consolidated_promo_item_type_name STRING(100)
OPTIONS(description='Name of the consolidated promotion item_1 type code.            "Postenartikel" = item_1 is a promotion item_1            "Sortimentsartikel" = item_1 is not a promotion item_1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_consolidated_promo_item_type_cd) NOT ENFORCED
)
OPTIONS(description='Generalized information about whether an item_1 should be regarded as a promotion item_1 or not in a certain context.             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN_1             CORE_REL: T_KFL_ITEM_LISTING_TYPE_1');