/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_consolidated_promotion_item_type
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:18:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item should be regarded as a promotion item or not.
            "PN" = item is a promotion item
            "SO" = item is not a promotion item
            "no typification" = item is not receiving a type (for LDL, only KFL items get a type)',
   kfl_consolidated_promo_item_type_name VARCHAR(100)     COMMENT 'Name of the consolidated promotion item type code.
            "Postenartikel" = item is a promotion item
            "Sortimentsartikel" = item is not a promotion item',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE PRIMARY KEY (kfl_consolidated_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Generalized information about whether an item should be regarded as a promotion item or not in a certain context.
             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN
             CORE_REL: T_KFL_ITEM_LISTING_TYPE';
