/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_consolidated_promotion_item_type
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:18:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_consolidated_promotion_item_type (
kfl_consolidated_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item should be regarded as a promotion item or not.            "PN" = item is a promotion item            "SO" = item is not a promotion item            "no typification" = item is not receiving a type (for LDL, only KFL items get a type)'),
kfl_consolidated_promo_item_type_name STRING(100)
OPTIONS(description='Name of the consolidated promotion item type code.            "Postenartikel" = item is a promotion item            "Sortimentsartikel" = item is not a promotion item'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_consolidated_promo_item_type_cd) NOT ENFORCED
)
OPTIONS(description='Generalized information about whether an item should be regarded as a promotion item or not in a certain context.             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN             CORE_REL: T_KFL_ITEM_LISTING_TYPE');