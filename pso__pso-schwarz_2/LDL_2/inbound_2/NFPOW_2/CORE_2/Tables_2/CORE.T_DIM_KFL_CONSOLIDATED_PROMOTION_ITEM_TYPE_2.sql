/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_consolidated_promotion_item_type_2
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:18:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_consolidated_promo_item_type_cd VARCHAR(100)     NOT NULL COMMENT 'This attribute consolidates the content of the KFL_ITEM_LIST_TYPE_CD into a generalized information about whether an item_2 should be regarded as a promotion item_2 or not.
            "PN" = item_2 is a promotion item_2
            "SO" = item_2 is not a promotion item_2
            "no typification" = item_2 is not receiving a type (for LDL, only KFL items get a type)',
   kfl_consolidated_promo_item_type_name VARCHAR(100)     COMMENT 'Name of the consolidated promotion item_2 type code.
            "Postenartikel" = item_2 is a promotion item_2
            "Sortimentsartikel" = item_2 is not a promotion item_2',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE PRIMARY KEY (kfl_consolidated_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Generalized information about whether an item_2 should be regarded as a promotion item_2 or not in a certain context.
             KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_POSTEN_2
             CORE_REL: T_KFL_ITEM_LISTING_TYPE_2';
