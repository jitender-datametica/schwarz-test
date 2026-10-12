CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_item_sales_variant_2 (nfpo_item_sid
OPTIONS(description='''Surrogate Key NFPO ITEM_2 INSTANCE.
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_SID
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_SID'''),
nfpo_gtin_nr
OPTIONS(description='''Assigned GTIN of one or more NFPO stock keeping units. A dummy_2 value is used to represent unknown variants of known items.
CBX: CNT_ITEM_2, LDL_ITEM_STYLE, LDL_ITEM_UNIQUE_STYLE_2, LDL_ITEM_SIZE_2, LDL_ITEM_LSV_2, LDL_ITEM_ARTICLE_EAN.LDL_EAN, LDL_EAN_KL
LDL: P_LEW_CORE.T_MDM_ITEM_SKU_EAN_HIST.BARCODE, KFL_BARCODE
CORE_REL: T_NFPO_ITEM_SKU_GTIN_HIST.LDL_GTIN_NR, KFL_GTIN_NR'''),
nfpo_item_nr
OPTIONS(description='''NFPO item_2 instance reference in the source (CBX).
CBX: CNT_ITEM.REF_NO
LDL: P_LEW_CORE.T_MDM_ITEM.SRC_ITEM_DOC_REF
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NR'''),
nfpo_item_name
OPTIONS(description='''NFPO item_2 name.
CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NAME'''),
ldl_item_ian_nr
OPTIONS(description='''Lidl International Item_2 Number (not necessarily unique in this table - numbers can be reused if an item_2 is cancelled, or multiple item_2 instances will be created for catalog items).
CBX: CNT_ITEM.ITEM_NO
LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
CORE_REL: T_NFPO_ITEM.LDL_ITEM_IAN_NR'''),
nfpo_item_sel_nr
OPTIONS(description='''NFPO source system (alternative) internal identifier for an article, constituting of a left part representing the range selection quarter in the year and the right the increment number of the counting number sequence of articles present in this range selection.
CBX: CNT_ITEM.LDL_SELECTION_NO
LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_SELECTION_NR
CORE_REL: T_NFPO_ITEM.NFPO_ITEM_SEL_NR'''),
nfpo_item_created_dt
OPTIONS(description='''Create date of NFPO item_2 instance record in the source system.
CBX: CNT_ITEM.CREATED_ON
LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_CREATED_TMSP
CORE_REL: T_NFPO_ITEM_HIST.NFPO_ITEM_CREATED_TMSP'''),
nfpo_item_set_style_nr
OPTIONS(description='''Identifier of the style composition in the source system.
CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_IDS
LDL: P_LEW_CORE.T_MDM_ITEM_SET.SRC_STYLE_UNIQIDS_CD
CORE_REL: T_NFPO_ITEM_SET.NFPO_ITEM_SET_STYLE_NR'''),
nfpo_item_set_style_name
OPTIONS(description='''List of names of the styles used in the set composition.
CBX: LDL_ITEM_UNIQUE_STYLE.LDL_ITEM_STYLE_PRODUCT_NAMES
LDL: P_LEW_CORE.T_MDM_ITEM_SET_HIST.STYLE_NAMES
CORE_REL: T_NFPO_ITEM_SET_HIST.NFPO_ITEM_SET_STYLE_NAME'''),
nfpo_item_size_nr
OPTIONS(description='''Identifier of the NFPO item_2 size for a certain item_2 in the source system.
CBX: LDL_ITEM_SIZE.CBXITEM_ITEMSIZE_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_SIZE.SRC_SIZE_CD
CORE_REL: T_NFPO_ITEM_SIZE.NFPO_ITEM_SIZE_NR'''),
nfpo_item_size_name
OPTIONS(description='''Name of the NFPO item_2 size.
CBX: LDL_ITEM_SIZE.LDL_NAME
LDL: P_LEW_CORE.T_MDM_ITEM_SIZE_HIST.SIZE_NAME
CORE_REL: T_NFPO_ITEM_SIZE_HIST.NFPO_ITEM_SIZE_NAME'''),
nfpo_item_variant_nr
OPTIONS(description='''Identifier of the regional NFPO item_2 variant for a certain item_2 in the source system.
CBX: LDL_ITEM_LSV.LDL_CODE
LDL: P_LEW_CORE.T_MDM_ITEM_VARIANT.SRC_VARIANT_CD
CORE_REL: T_NFPO_ITEM_VARIANT.NFPO_ITEM_VARIANT_NR'''),
nfpo_item_variant_name
OPTIONS(description='''Name of the regional NFPO item_2 variant.
CBX: LDL_ITEM_LSV.LDL_NAME
LDL: P_LEW_CORE.T_MDM_ITEM_VARIANT_HIST.VARIANT_NAME
CORE_REL: T_NFPO_ITEM_VARIANT_HIST.NFPO_ITEM_VARIANT_NAME'''),
nfpo_item_sales_variant_color_list_txt
OPTIONS(description='''Item_2 style color description. Non-standard textual entries referring to color descriptions.
CBX: LDL_ITEM_STYLE.LDL_FARBE
LDL: P_LEW_CORE.T_MDM_ITEM_STYLE_HIST.COLOR_DESCR
CORE_REL: T_NFPO_ITEM_STYLE_HIST.NFPO_ITEM_STYLE_COLOR_DESCR'''),
nfpo_item_sku_weight_kg_meas
OPTIONS(description='''Defined weight in kilogramm for the stock keeping unit.
CBX: CBX_LDL_ITEM_ARTICLE_EAN.LDL_UNIT_WT
LDL: P_LEW_CORE.T_MDM_ITEM_SKU_HIST.MDM_ITEM_SKU_WEIGHT_KG_MEAS
CORE_REL: T_NFPO_ITEM_SKU_HIST.NFPO_ITEM_SKU_WEIGHT_KG_MEAS'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.')
)
OPTIONS(description = 'NFPO item_2 sales_2 variant dimension. An item_2 sales_2 variant is the combination of an NFPO item_2 and a GTIN defined for this item_2 in CBX. In addition to this, for every NFPO item_2 an unknown sales_2 variant is defined covering all data which can be associated to the NFPO item_2 but not to a specific GTIN of the item_2 in CBX.')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_item_sales_variant_2;