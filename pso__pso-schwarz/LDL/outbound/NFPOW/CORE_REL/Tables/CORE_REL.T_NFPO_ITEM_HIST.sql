/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_hist
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_hist (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Foreign Key NFPO ITEM INSTANCE.
            CBX: CNT_ITEM.REF_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_ITEM_SID'''),
nfpo_item_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Technical version of the NFPO item in the source system.
            CBX: CNT_ITEM.VERSION
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_VERSION_NR'''),
nfpo_item_status_cd STRING(100)
OPTIONS(description='''Technical status of the NFPO item in the source system (active, inactive, cancelled).
            CBX: CNT_ITEM.DOC_STATUS
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_DOC_STATUS'''),
nfpo_item_created_tmsp DATETIME NOT NULL
OPTIONS(description='''Create timestamp of NFPO item instance record in the source system.
            CBX: CNT_ITEM.CREATED_ON
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_CREATED_TMSP'''),
nfpo_item_change_tmsp DATETIME NOT NULL
OPTIONS(description='''Change timestamp of NFPO item instance record in the source system.
            CBX: CNT_ITEM.UPDATED_ON
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CBX_ITEM_CHANGE_TMSP'''),
nfpo_market_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key NFPO MARKET  (EU, INTEGER , US).
            CBX: CNT_ITEM.LDL_CONTINENT_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MARKET_SID'''),
nfpo_item_fam_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key ITEM FAMILY GROUP.
            CBX: CNT_ITEM.LDL_ARTICLE_GROUP
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_FAM_GRP_SID'''),
nfpo_ldl_brand_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key BRAND.
            CBX: CNT_ITEM.LDL_BRAND
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.BRAND_SID'''),
nfpo_kfl_brand_sid BIGNUMERIC(38,0)
OPTIONS(description='''Surrogate Key KFL BRAND, identifies the brand in case of being sold in a Kaufland country.
            CBX: CNT_ITEM.LDL_BRAND_KL
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.KFL_BRAND_SID'''),
nfpo_item_origin_country_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key POLITICAL COUNTRY, the manufacturing country of the item.
            CBX: CNT_ITEM.LDL_COUNTRY_OF_ORIGIN
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.COUNTRY_POL_SID_ORIGIN'''),
nfpo_sup_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key NFPO SUPPLIER.
            CBX: CNT_ITEM.LDL_DEFAULT_VENDOR_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_SUP_SID'''),
nfpo_gtin_ownership_cd STRING(100)
OPTIONS(description='''NFPO GTIN assignment responsibility code.
            CBX: CTM_VENDOR.CUST_CODELIST1
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.EAN_OWNERSHIP_CD'''),
nfpo_final_sup_fg BOOL
OPTIONS(description='''Indicates whether the supplier is finally fixed.
            CBX: CNT_ITEM.LDL_FINAL_VENDOR
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.SUP_FINAL_FG'''),
nfpo_item_workflow_status_id BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key NFPO ITEM WORKFLOW STATUS.The workflow is about the item definition, from creation to clearance.
            CBX: CNT_ITEM.STATUS (substring after \'customStatus\')
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_WORKFLOW_STATUS_ID'''),
nfpo_item_creation_class_cd STRING(100)
OPTIONS(description='''NFPO item classification code related to item creation and usage over time.
            The item creation class indicates the item creation process from which the article came, e.g. a range selection that applies to all organizations, or from a local selection process that only applies to the country, etc.
            CBX: CNT_ITEM.LDL_ARTICLE_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_CLASS_CD'''),
nfpo_org_order_status_cd STRING(100)
OPTIONS(description='''NFPO status code related to the order quantity definition process for the local NFPO\'s of items.
            CBX: CNT_ITEM.LDL_COUNTRY_ORDER_STATUS
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.BUY_STATUS_CD'''),
nfpo_display_type_cd STRING(100)
OPTIONS(description='''NFPO display type code.
            CBX: CNT_ITEM.LDL_DISPLAY_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DISPLAY_TYPE_CD'''),
nfpo_hier_node_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key HIERARCHY NODE.
            CBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.HIER_NODE_SID'''),
nfpo_item_collection_txt STRING(1000)
OPTIONS(description='''Item collection (related group of articles, free text).
            CBX: CNT_ITEM.LDL_ITEM_COLLECTION
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_COLLECTION'''),
nfpo_item_note_txt STRING(4000)
OPTIONS(description='''Item procurement notes.
            CBX: CNT_ITEM.LDL_EK_NOTE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_NOTES'''),
nfpo_warranty_dur_cd STRING(100)
OPTIONS(description='''NFPO warranty duration code.
            CBX: CNT_ITEM.LDL_GUARANTEE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.GUARANTEE_CD'''),
nfpo_warranty_type_cd STRING(100)
OPTIONS(description='''NFPO warranty type code.
            CBX: CNT_ITEM.LDL_WARRANTY_ART_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.GUARANTEE_TYPE_CD'''),
nfpo_warranty_type_descr STRING(4000)
OPTIONS(description='''NFPO warranty type long description.
            CBX: CNT_ITEM.LDL_ART
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.GUARANTEE_ART'''),
nfpo_item_quality_class_cd STRING(100)
OPTIONS(description='''NFPO item quality classification code.
            CBX: CNT_ITEM.LDL_ARTICLE_CLASS
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_QUALITY_CLASS_CD'''),
nfpo_pillar_sid BIGNUMERIC(38,0)
OPTIONS(description='''Surrogate Key NFPO PILLAR. Identifier of the pillar in NFPO source system. Alternative item grouping for non food items in addition to the standard grouping based on item families.
            CBX: CNT_ITEM.LDL_PILLAR
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_PILLAR_SID'''),
nfpo_main_pillar_cd STRING(100)
OPTIONS(description='''Main pillar code (TX/HG).
            CBX: CNT_ITEM.PRODUCT_CATEGORY_VALUE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MAIN_PILLAR_CD'''),
nfpo_cust_need_type_cd STRING(100)
OPTIONS(description='''Code to classify the assortment by general customer needs.
            CBX: CNT_ITEM.LDL_FOCUS_CATEGORY
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CUST_NEED_TYPE_CD'''),
nfpo_cust_need_subtype_cd STRING(100)
OPTIONS(description='''Code to classify the assortment by detailed customer needs.
            CBX: CNT_ITEM.LDL_CATEGORY_NEEDS
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CUST_NEED_SUBTYPE_CD'''),
nfpo_assort_profile_type_cd STRING(100)
OPTIONS(description='''Code to indicate the importance profile of the item in the assortment (Pflicht, Profilierung, Erg�nzung).
            CBX: CNT_ITEM.LDL_FMS_ASSORTMENT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ASSORT_PROFILE_TYPE_CD'''),
ldl_core_assort_type_cd STRING(100)
OPTIONS(description='''Code of the type how the item can be regarded to be part of the Lidl core assortment.
            CBX: CNT_ITEM.ldl_core_article
            LDL:P_LEW_CORE.T_MDM_ITEM_HIST..core_assort_type_cd'''),
nfpo_item_split_role_cd STRING(100)
OPTIONS(description='''NFPO code for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\').
            CBX: CNT_ITEM.LDL_PARENT_OR_CHILD
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_ITEM_SPLIT_ROLE_CD'''),
nfpo_item_split_method_cd STRING(100)
OPTIONS(description='''NFPO code for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\').
            CBX: CNT_ITEM.LDL_STYLE_SPLIT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_ITEM_SPLIT_METHOD_CD'''),
nfpo_list_type_cd STRING(100)
OPTIONS(description='''NFPO codes for list types of items.
            CBX: CNT_ITEM.LDL_ASSORT_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_LIST_TYPE_CD'''),
nfpo_item_innovation_fg BOOL
OPTIONS(description='''Indicates whether an item is an innovation article (1) or not (0).
            CBX: CNT_ITEM.LDL_INNOVATION_ART
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.INNOVATION_FG'''),
nfpo_season_name STRING(100)
OPTIONS(description='''Name of the season in case of a season related item.
            CBX: CNT_ITEM.SEASON
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.SEASON_NAME'''),
nfpo_catalog_item_fg BOOL
OPTIONS(description='''Indicator whether an item is a catalog item or not. Catalog items will get extra item instances for every range selection where they are valid. The conditions and properties remain unchanged.
            CBX: CNT_ITEM.LDL_CAT_INDICATOR
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CATALOG_FG'''),
nfpo_item_cancel_reason_name STRING(100)
OPTIONS(description='''Cancellation reason name if the item has been cancelled.
            CBX: CNT_ITEM.LDL_CANCELLATION_REASON
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CANCEL_REASON_NAME'''),
nfpo_init_range_plan_nr STRING(100)
OPTIONS(description='''Initial batch of the item.
            CBX: CNT_ITEM.LDL_INITIAL_LOT_NO
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.INITIAL_RANGE_PLAN_CD'''),
ldl_relevant_fg BOOL
OPTIONS(description='''Indicates whether this item is relevant to be sold by Lidl.
            CBX: CNT_ITEM.LDL_NO_LIDL_ITEM
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.LDL_RELEVANT_FG'''),
kfl_relevant_fg BOOL
OPTIONS(description='''Indicates whether this item is relevant to be sold by Kaufland.
            CBX: CNT_ITEM.LDL_KL_DECISION
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.KFL_RELEVANT_FG'''),
nfpo_pack_type_cd STRING(100)
OPTIONS(description='''NFPO outer package type codes for items.
            CBX: CNT_ITEM.LDL_PACKING_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.PACKAGE_TYPE_CD'''),
controlled_price_fg BOOL
OPTIONS(description='''Indicates whether the price is controlled outside NFPO.
            CBX: CNT_ITEM.LDL_BINDING_PRICE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CONTROLLED_PRICE_FG'''),
nfpo_item_highlight_fg BOOL
OPTIONS(description='''Indicates whether the item should be placed prominently during the internal trade show.
            CBX: CNT_ITEM.LDL_BRIEF_HIGHLIGHT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_HIGHLIGHT_FG'''),
nfpo_item_init_order_fg BOOL
OPTIONS(description='''Indicator for the initial item instance order of a catalog item.
            CBX: CNT_ITEM.LDL_INITIAL_ORDER
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.INITIAL_ORDER_FG'''),
nfpo_item_unit_uom_sid BIGNUMERIC(38,0)
OPTIONS(description='''Indicator in the item planning process: Surrogate Key ITEM CONTENT UNIT OF MEASUREMENT. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_CONTAINER_UNIT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_CONTENT_UOM_SID'''),
nfpo_item_unit_uom_nr STRING(100)
OPTIONS(description='''Indicator in the item planning process: code of the item content unit of measurement. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_CONTAINER_UNIT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_CONTENT_UOM_CD'''),
nfpo_item_unit_qty BIGNUMERIC(38,5)
OPTIONS(description='''Indicator in the item planning process: quantity of the content of units of the item. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_CONTAINER_VOLUME
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_UNIT_QTY'''),
nfpo_item_unit_cnt BIGNUMERIC(38,0)
OPTIONS(description='''Indicator in the item planning process: number of units the item consists of for the main variant. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_NUMBER_OF_CONTAINER
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_UNIT_CNT'''),
nfpo_item_min_order_qty BIGNUMERIC(38,5)
OPTIONS(description='''Minimum of the order quantity for a catalog item.
            CBX: CNT_ITEM.LDL_MOQ
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MINIMAL_ORDER_QTY'''),
nfpo_item_initiating_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''Organization which initiates the item due to competitor items.
            CBX: CNT_ITEM.LDL_STORE_CHECK_NAME
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_INITIATING_INT_ORG_SID'''),
nfpo_item_proposing_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''Organization which proposed this item.
            CBX: CNT_ITEM.LDL_COUNTRY_PROPOSAL
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_PROPOSING_INT_ORG_SID'''),
nfpo_case_size_qty BIGNUMERIC(38,5)
OPTIONS(description='''Predefined number of items in the sort boxes of the item. All sort boxes will have the same case_size_qty. 
            CBX: CNT_ITEM.LDL_UNIT_OF_CARTON
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CASE_SIZE_QTY'''),
nfpo_catalog_item_contract_expiry_dt DATE
OPTIONS(description='''For catalog items, this field stores the expiry date of the contract.
            CBX: CNT_ITEM.LDL_CONTRACT_EXPIRY_DATE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.CONTRACT_EXPIRY_DT'''),
nfpo_item_composition_cd STRING(100)
OPTIONS(description='''Indicator in the item planning process: indicates whether an item has relevant variants or consists of certain sub parts. Interpretation depends on the overall composition of the item (assort or assemble: (x)fach sortiert oder (x)teilig).
            CBX: CNT_ITEM.LDL_ASSORTMENT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_ITEM_COMPOSITION_CD'''),
nfpo_item_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='''Indicator in the item planning process: number of relevant variants the item has from the design point of view. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_NUM_OF_UNITS
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.ITEM_VARIANT_CNT'''),
nfpo_case_composition_cd STRING(100)
OPTIONS(description='''Indicator in the item planning process: indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items. Interpretation depends on the overall composition of the item.
            CBX: CNT_ITEM.LDL_PACK_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_CASE_COMPOSITION_CD'''),
nfpo_item_quality_comment_txt STRING(1000)
OPTIONS(description='''Free text remark related to the NFPO item from the quality development team point of view.
            CBX: CNT_ITEM.LDL_REMARK_QE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.QUALITY_COMMENT_TXT'''),
nfpo_item_purch_comment_txt STRING(1000)
OPTIONS(description='''Free text remark related to the NFPO item from the purchasing team point of view.
            CBX: CNT_ITEM.LDL_REMARK_EK
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.PURCH_COMMENT_TXT'''),
nfpo_smart_item_fg BOOL
OPTIONS(description='''The flag indicates whether an item is regarded to be a smart item or not.
            The definition of a smart item is not standardized. It can be an IOT item or have connectivity / networking capabilities. Items whose networking capability is a central component of their use, like a printer, may not be considered smart items.
            CBX: CNT_ITEM.LDL_IOT
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_SMART_ITEM_FG'''),
nfpo_logistics_class_cd STRING(100)
OPTIONS(description='''Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
            CBX: CNT_ITEM.LDL_DELIVERY_TYPE
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_LOGISTICS_CLASS_CD'''),
nfpo_ldl_sales_packaging_type_cd STRING(100)
OPTIONS(description='''Code of the sales packaging type to be used for sales in the line of business Lidl.
            CBX: CNT_ITEM.LDL_RETAIL_PACKAGING
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_LDL_SALES_PACKAGING_TYPE_CD'''),
nfpo_kfl_sales_packaging_type_cd STRING(100)
OPTIONS(description='''Code of the sales packaging type to be used for sales in the line of business Kaufland.
            CBX: CNT_ITEM.LDL_RETAIL_PACKAGING_KL
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_KFL_SALES_PACKAGING_TYPE_CD'''),
eu_data_act_relevant_fg BOOL
OPTIONS(description='''The flag indicates whether an item is relevant for EU Data act or not.
            CBX:CNT_ITEM.LDL_EU_DATA_ACT
            LDL:  P_LEW_CORE.T_MDM_ITEM_HIST.EU_DATA_ACT_RELEVANT_FG'''),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='''If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DELETED_FG'''),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_VALID_FROM'''),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_VALID_TO'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='''Instances of NFPO items in the quarterly item planning and ordering process. For catalog items there might be several instances in this table, all sharing the same international article number.
             CBX: CNT_ITEM
             LDL: P_LEW_CORE.T_MDM_ITEM_HIST''');