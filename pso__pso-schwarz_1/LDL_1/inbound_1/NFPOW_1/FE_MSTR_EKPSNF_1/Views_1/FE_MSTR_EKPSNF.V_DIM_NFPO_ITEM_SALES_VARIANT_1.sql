CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_SALES_VARIANT_1 (
   nfpo_item_sid                            COMMENT 'Surrogate Key NFPO ITEM_1 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_SID'
  ,nfpo_gtin_nr                             COMMENT 'Assigned GTIN of one or more NFPO stock keeping units. A dummy_1 value is used to represent unknown variants of known items.
CBX: CNT_ITEM_1, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_SIZE_1, LDL_ITEM_LSV_1, LDL_ITEM_ARTICLE_EAN.LDL_EAN, LDL_EAN_KL
LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.BARCODE, KFL_BARCODE
CORE_REL: T_NFPO_ITEM_SKU_GTIN_HIST.LDL_GTIN_NR, KFL_GTIN_NR'
  ,nfpo_item_nr                             COMMENT 'NFPO item_1 instance reference in the source (CBX).
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NR'
  ,nfpo_item_name                           COMMENT 'NFPO item_1 name.
CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NAME'
  ,ldl_item_ian_nr                          COMMENT 'Lidl International Item_1 Number (not necessarily unique in this table - numbers can be reused if an item_1 is cancelled, or multiple item_1 instances will be created for catalog items).
CBX: CNT_ITEM.ITEM_NO
LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
CORE_REL: T_NFPO_ITEM.LDL_ITEM_IAN_NR'
  ,nfpo_item_sel_nr                         COMMENT 'NFPO source system (alternative) internal identifier for an article, constituting of a left part representing the range selection quarter in the year and the right the increment number of the counting number sequence of articles present in this range selection.
CBX: CNT_ITEM.LDL_SELECTION_NO
LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_SELECTION_NR
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_SEL_NR'
  ,nfpo_item_created_dt                     COMMENT 'Create date of NFPO item_1 instance record in the source system.
CBX: CNT_ITEM.CREATED_ON
LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_CREATED_TMSP
CORE_REL: T_NFPO_ITEM_HIST.NFPO_ITEM_CREATED_TMSP'
  ,nfpo_item_set_style_nr                   COMMENT 'Identifier of the style composition in the source system.
CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS
LDL: P_LEW_CORE.T_MDM_ITEM_SET.SRC_STYLE_UNIQIDS_CD
CORE_REL: T_NFPO_ITEM_SET.NFPO_ITEM_SET_STYLE_NR'
  ,nfpo_item_set_style_name                 COMMENT 'List of names of the styles used in the set composition.
CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_PRODUCT_NAMES
LDL: P_LEW_CORE.T_MDM_ITEM_SET_HIST.STYLE_NAMES
CORE_REL: T_NFPO_ITEM_SET_HIST.NFPO_ITEM_SET_STYLE_NAME'
  ,nfpo_item_size_nr                        COMMENT 'Identifier of the NFPO item_1 size for a certain item_1 in the source system.
CBX: LDL_ITEM_SIZE.CBXITEM_ITEMSIZE_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_SIZE.SRC_SIZE_CD
CORE_REL: T_NFPO_ITEM_SIZE.NFPO_ITEM_SIZE_NR'
  ,nfpo_item_size_name                      COMMENT 'Name of the NFPO item_1 size.
CBX: LDL_ITEM_SIZE.LDL_NAME
LDL: P_LEW_CORE.T_MDM_ITEM_SIZE_HIST.SIZE_NAME
CORE_REL: T_NFPO_ITEM_SIZE_HIST.NFPO_ITEM_SIZE_NAME'
  ,nfpo_item_variant_nr                     COMMENT 'Identifier of the regional NFPO item_1 variant for a certain item_1 in the source system.
CBX: LDL_ITEM_LSV.LDL_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_VARIANT.SRC_VARIANT_CD
CORE_REL: T_NFPO_ITEM_VARIANT.NFPO_ITEM_VARIANT_NR'
  ,nfpo_item_variant_name                   COMMENT 'Name of the regional NFPO item_1 variant.
CBX: LDL_ITEM_LSV.LDL_NAME
LDL: P_LEW_CORE.T_MDM_ITEM_VARIANT_HIST.VARIANT_NAME
CORE_REL: T_NFPO_ITEM_VARIANT_HIST.NFPO_ITEM_VARIANT_NAME'
  ,nfpo_item_sales_variant_color_list_txt   COMMENT 'Item_1 style color description. Non-standard textual entries referring to color descriptions.
CBX: LDL_ITEM_STYLE.LDL_FARBE
LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.COLOR_DESCR
CORE_REL: T_NFPO_ITEM_STYLE_HIST.NFPO_ITEM_STYLE_COLOR_DESCR'
  ,nfpo_item_sku_weight_kg_meas             COMMENT 'Defined weight in kilogramm for the stock keeping unit.
CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT
LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.MDM_ITEM_SKU_WEIGHT_KG_MEAS
CORE_REL: T_NFPO_ITEM_SKU_HIST.NFPO_ITEM_SKU_WEIGHT_KG_MEAS'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'NFPO item_1 sales_1 variant dimension. An item_1 sales_1 variant is the combination of an NFPO item_1 and a GTIN defined for this item_1 in CBX. In addition to this, for every NFPO item_1 an unknown sales_1 variant is defined covering all data which can be associated to the NFPO item_1 but not to a specific GTIN of the item_1 in CBX.'
AS SELECT
   nfpo_item_sid
  ,nfpo_gtin_nr
  ,nfpo_item_nr
  ,nfpo_item_name
  ,ldl_item_ian_nr
  ,nfpo_item_sel_nr
  ,nfpo_item_created_dt
  ,nfpo_item_set_style_nr
  ,nfpo_item_set_style_name
  ,nfpo_item_size_nr
  ,nfpo_item_size_name
  ,nfpo_item_variant_nr
  ,nfpo_item_variant_name
  ,nfpo_item_sales_variant_color_list_txt
  ,nfpo_item_sku_weight_kg_meas
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ITEM_SALES_VARIANT_1
;