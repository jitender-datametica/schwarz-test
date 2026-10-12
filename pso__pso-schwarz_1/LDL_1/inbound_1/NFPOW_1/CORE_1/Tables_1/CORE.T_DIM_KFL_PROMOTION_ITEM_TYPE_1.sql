/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_promotion_item_type_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_KFL_PROMOTION_ITEM_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.MANDANT_ID
            CORE_REL: t_kfl_promotion_item_type.kfl_client_id',
   kfl_promo_item_type_cd              VARCHAR(100)     NOT NULL COMMENT 'current type of the promotion of an item_1 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_KZ_SAP
            CORE_REL: t_kfl_promotion_item_type.kfl_promo_item_type_cd',
   kfl_promo_item_type_name            VARCHAR(100)     NOT NULL COMMENT 'German name of the current type of the promotion of an item_1 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_BEZ_SAP
            CORE_REL: t_kfl_promotion_item_type.kfl_promo_item_type_name',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_KFL_PROMOTION_ITEM_TYPE PRIMARY KEY (kfl_client_id, kfl_promo_item_type_cd) NOT ENFORCED 
)  COMMENT = 'Kaufland type of promotion context for items
             KFL: DBP_DATA.POSTEN_KZ_SAP_SPR_ZU_1
             CORE_REL: T_KFL_PROMOTION_ITEM_TYPE_1';

