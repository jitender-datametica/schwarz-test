/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_local_item_sales_variant_1
   generated from Powerdesigner on Montag, 30. September 2024 16:57:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LDL_LOCAL_ITEM_SALES_VARIANT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   lob_cd                              VARCHAR(100)     NOT NULL COMMENT 'line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH',
   ldl_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key of the item_1 in the Lidl DWH',
   gtin_nr                             VARCHAR(100)     NOT NULL COMMENT 'Assigned GTIN of the NFPO stock keeping unit_1 for Kaufland.or Lidl
            CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL or LDL_EAN
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE or BARCODE
            CORE_REL: T_NFPO_ITE_SKU_GTIN_HIST.KFL_GTIN_NR or LDL_GTIN_NR',
   nfpo_item_set_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO item_1 set
            CBX: 1. CNT_ITEM_1, LDL_ITEM_VARIANT
            2. CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV.
            1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS
            2. CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.MDM_ITEM_SET_SID',
   nfpo_item_set_style_nr              VARCHAR(2000)    NOT NULL COMMENT 'Identifier of the style composition in the source system.
            CBX: 1. CNT_ITEM_1, LDL_ITEM_VARIANT
            2. CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV.
            1. LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS
            2. LDL_STYLE_UNIQUE_IDS
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.SRC_STYLE_UNIQIDS_CD',
   nfpo_item_set_style_name            VARCHAR(4000)    COMMENT 'List of names of the styles used in the set composition.
            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_PRODUCT_NAMES
            LDL: P_LEW_CORE.T_MDM_ITEM_SET_HIST.STYLE_NAMES',
   nfpo_item_size_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO ITEM_1 SIZE.
            CBX: CNT_ITEM_1,
            LDL_ITEM_SIZE.CNT_ITEM.REF_NO,
            LDL_ITEM_SIZE.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.MDM_ITEM_SIZE_SID',
   nfpo_item_size_nr                   VARCHAR(300)     NOT NULL COMMENT 'Identifier of the NFPO item_1 size for a certain item_1 in the source system.
            CBX: 1. CNT_ITEM_1, LDL_ITEM_VARIANT
            2. CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV.
            1. LDL_ITEM_VARIANT.LDL_SIZE_CODE
            2. LDL_ITEM_SIZE.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.SRC_SIZE_CD',
   nfpo_item_size_name                 VARCHAR(300)     COMMENT 'Name of the NFPO item_1 size.
            CBX: LDL_ITEM_SIZE.LDL_NAME
            LDL: P_LEW_CORE.T_MDM_ITEM_SIZE_HIST.SIZE_NAME',
   nfpo_item_variant_sid               NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key regional NFPO ITEM_1 VARIANT.
            CBX: 1. CNT_ITEM_1, LDL_ITEM_VARIANT
            2. CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV.
            1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. CNT_ITEM.REF_NO, LDL_ITEM_LSV.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.MDM_ITEM_VARIANT_SID',
   nfpo_item_variant_nr                VARCHAR(100)     NOT NULL COMMENT 'Identifier of the regional NFPO item_1 variant for a certain item_1 in the source system.
            CBX: 1. CNT_ITEM_1, LDL_ITEM_VARIANT
            2. CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_LSV_CODE
            2. LDL_ITEM_LSV.LDL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.SRC_VARIANT_CD',
   nfpo_item_variant_name              VARCHAR(300)     COMMENT 'Name of the regional NFPO item_1 variant.
            CBX: LDL_ITEM_LSV.LDL_NAME
            LDL: P_LEW_CORE.T_MDM_ITEM_VARIANT_HIST.VARIANT_NAME',
   ldl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key of the ERP client in the Lidl DWH',
   ldl_item_nr                         NUMBER(38,0)     COMMENT 'number of the local item_1 in the Lidl ERP system WAWI, for CBX based non food items this number is equal to the IAN',
   case_size_qty                       NUMBER(38,5)     COMMENT 'case size of the logistic variant of the local item_1',
   active_from_dt                      DATE             COMMENT 'begin date of the validity_1 period of the item_1 in the Lidl ERP system WAWI',
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item_1 Number.',
   ldl_brand_list_type_id              NUMBER(38,0)     COMMENT 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist_1',
   ldl_list_type_id                    NUMBER(38,0)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.listing_type_id',
   ldl_brand_name                      VARCHAR(100)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.brand_1',
   ldl_item_fam_grp_nr                 NUMBER(38,0)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_familygroup_id',
   ldl_sub_item_grp_id                 NUMBER(38,0)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.subitemgroup_id',
   ldl_item_name                       VARCHAR(100)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_desc',
   item_origin_type_cd                 VARCHAR(100)     COMMENT 'indicator which process originally created the item_1',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_LDL_LOCAL_ITEM_SALES_VARIANT PRIMARY KEY (lob_cd, ldl_item_sid, gtin_nr) NOT ENFORCED 
)  COMMENT = 'Lidl item_1 sales_1 variant dimension table. A Lidl item_1 sales_1 variant is defined by a GTIN associated to a certain Lidl item_1 (logistic) variant.';
