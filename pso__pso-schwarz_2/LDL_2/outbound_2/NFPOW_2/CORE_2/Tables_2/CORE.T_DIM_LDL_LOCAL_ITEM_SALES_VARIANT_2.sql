/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_local_item_sales_variant_2
   generated from Powerdesigner on Montag, 30. September 2024 16:57:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_local_item_sales_variant_2 (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, "KFL" if the data is taken from the Kaufland DWH, "LDL" if the data is taken from a Lidl DWH'),
ldl_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key of the item_2 in the Lidl DWH'),
gtin_nr STRING(100) NOT NULL
OPTIONS(description='Assigned GTIN of the NFPO stock keeping unit_2 for Kaufland.or Lidl            CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.LDL_EAN_KL or LDL_EAN            LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.KFL_BARCODE or BARCODE            CORE_REL: T_NFPO_ITE_SKU_GTIN_HIST.KFL_GTIN_NR or LDL_GTIN_NR'),
nfpo_item_set_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO item_2 set            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.            1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS            2. CNT_ITEM.REF_NO, LDL_STYLE_UNIQUE_IDS            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.MDM_ITEM_SET_SID'),
nfpo_item_set_style_nr STRING(2000) NOT NULL
OPTIONS(description='Identifier of the style composition in the source system.            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.            1. LDL_ITEM_VARIANT.LDL_STYLE_UNIQUE_IDS            2. LDL_STYLE_UNIQUE_IDS            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.SRC_STYLE_UNIQIDS_CD'),
nfpo_item_set_style_name STRING(4000)
OPTIONS(description='List of names of the styles used in the set composition.            CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_PRODUCT_NAMES            LDL: P_LEW_CORE.T_MDM_ITEM_SET_HIST.STYLE_NAMES'),
nfpo_item_size_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO ITEM_2 SIZE.            CBX: CNT_ITEM_2,            LDL_ITEM_SIZE.CNT_ITEM.REF_NO,            LDL_ITEM_SIZE.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.MDM_ITEM_SIZE_SID'),
nfpo_item_size_nr STRING(300) NOT NULL
OPTIONS(description='Identifier of the NFPO item_2 size for a certain item_2 in the source system.            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.            1. LDL_ITEM_VARIANT.LDL_SIZE_CODE            2. LDL_ITEM_SIZE.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.SRC_SIZE_CD'),
nfpo_item_size_name STRING(300)
OPTIONS(description='Name of the NFPO item_2 size.            CBX: LDL_ITEM_SIZE.LDL_NAME            LDL: P_LEW_CORE.T_MDM_ITEM_SIZE_HIST.SIZE_NAME'),
nfpo_item_variant_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key regional NFPO ITEM_2 VARIANT.            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.            1. CNT_ITEM.REF_NO, LDL_ITEM_VARIANT.LDL_LSV_CODE            2. CNT_ITEM.REF_NO, LDL_ITEM_LSV.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.MDM_ITEM_VARIANT_SID'),
nfpo_item_variant_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the regional NFPO item_2 variant for a certain item_2 in the source system.            CBX: 1. CNT_ITEM_2, LDL_ITEM_VARIANT            2. CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV.1. LDL_ITEM_VARIANT.LDL_LSV_CODE            2. LDL_ITEM_LSV.LDL_CODE            LDL: P_LEW_CORE.T_MDM_ITEM_SKU.SRC_VARIANT_CD'),
nfpo_item_variant_name STRING(300)
OPTIONS(description='Name of the regional NFPO item_2 variant.            CBX: LDL_ITEM_LSV.LDL_NAME            LDL: P_LEW_CORE.T_MDM_ITEM_VARIANT_HIST.VARIANT_NAME'),
ldl_client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the ERP client in the Lidl DWH'),
ldl_item_nr BIGNUMERIC(38,0)
OPTIONS(description='number of the local item_2 in the Lidl ERP system WAWI, for CBX based non food items this number is equal to the IAN'),
case_size_qty BIGNUMERIC(38,5) OPTIONS(description='case size of the logistic variant of the local item_2'),
active_from_dt DATE OPTIONS(description='begin date of the validity_2 period of the item_2 in the Lidl ERP system WAWI'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lidl International Item_2 Number.'),
ldl_brand_list_type_id BIGNUMERIC(38,0)
OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist_2'),
ldl_list_type_id BIGNUMERIC(38,0) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.listing_type_id'),
ldl_brand_name STRING(100) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.brand_2'),
ldl_item_fam_grp_nr BIGNUMERIC(38,0) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_familygroup_id'),
ldl_sub_item_grp_id BIGNUMERIC(38,0) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.subitemgroup_id'),
ldl_item_name STRING(100) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_desc'),
item_origin_type_cd STRING(100) OPTIONS(description='indicator which process originally created the item_2'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, ldl_item_sid, gtin_nr) NOT ENFORCED
)
OPTIONS(description='Lidl item_2 sales_2 variant dimension table. A Lidl item_2 sales_2 variant is defined by a GTIN associated to a certain Lidl item_2 (logistic) variant.');