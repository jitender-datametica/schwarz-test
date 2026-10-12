create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_MDM_ITEM_HIST_1(
	CLIENT_ID COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.',
	MDM_ITEM_SID COMMENT 'surrogate key NFPO item_1 instance\nCBX: CNT_ITEM.REF_NO',
	CBX_ITEM_VERSION_NR COMMENT 'technical version of the NFPO item_1 in the source system\nCBX: CNT_ITEM.VERSION',
	CBX_ITEM_DOC_STATUS COMMENT 'technical status_1 of the NFPO item_1 in the source system (active,inactive,cancelled)\nCBX: CNT_ITEM.DOC_STATUS',
	CBX_ITEM_CREATED_TMSP COMMENT 'creation timestamp of NFPO item_1 instance record in the source system\nCBX: CNT_ITEM.CREATED_ON',
	CBX_ITEM_CHANGE_TMSP COMMENT 'change timestamp of NFPO item_1 instance record in the source system\nCBX: CNT_ITEM.UPDATED_ON',
	MARKET_SID COMMENT 'foreign key NFPO market\nCBX: CNT_ITEM.LDL_CONTINENT_TYPE',
	ITEM_FAM_GRP_SID COMMENT 'foreign key item_1 family group\nCBX: CNT_ITEM.LDL_ARTICLE_GROUP',
	BRAND_SID COMMENT 'foreign key brand_1\nCBX: CNT_ITEM.LDL_BRAND',
	COUNTRY_POL_SID_ORIGIN COMMENT 'foreign key political country_1, here the manufacturing country_1 of the item_1 is used\nCBX: CNT_ITEM.LDL_COUNTRY_OF_ORIGIN',
	MDM_SUP_SID COMMENT 'foreign key NFPO supplier_1\nCBX: CNT_ITEM.LDL_DEFAULT_VENDOR_REF',
	EAN_OWNERSHIP_CD COMMENT 'NFPO GTIN assignement responisbility code\nCBX: CTM_VENDOR.CUST_CODELIST1',
	SUP_FINAL_FG COMMENT 'indicated whether the supplier_1 is finally fixed\nCBX: CNT_ITEM.LDL_FINAL_VENDOR',
	ITEM_WORKFLOW_STATUS_ID COMMENT 'foreign key NFPO item_1 workflow status_1\nCBX: CNT_ITEM.STATUS_1 substringAfter(\""customStatus\"")',
	ITEM_CLASS_CD COMMENT 'NFPO item_1 classification code related to item_1 creation and usage over time\nCBX: CNT_ITEM.LDL_ARTICLE_TYPE',
	BUY_STATUS_CD COMMENT 'NFPO status_1 code related to the order quantity definition process for the local NFPOs of items\nCBX: CNT_ITEM.LDL_COUNTRY_ORDER_STATUS',
	DISPLAY_TYPE_CD COMMENT 'NFPO display type code\nCBX: CNT_ITEM.LDL_DISPLAY_TYPE',
	HIER_NODE_SID COMMENT 'FK Node\nCBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE',
	ITEM_COLLECTION COMMENT 'Item_1 collection (related group of articles, free text)\nCBX: CNT_ITEM.LDL_ITEM_COLLECTION',
	ITEM_NOTES COMMENT 'Item_1 procurement notes;\nCBX: CNT_ITEM.LDL_EK_NOTE',
	GUARANTEE_CD COMMENT 'NFPO warranty duration code\nCBX: CNT_ITEM.LDL_GUARANTEE',
	GUARANTEE_TYPE_CD COMMENT 'NFPO warranty type code\nCBX: CNT_ITEM.LDL_WARRANTY_ART_TYPE',
	GUARANTEE_ART COMMENT 'NFPO warranty type long description\nCBX: CNT_ITEM.LDL_ART',
	ITEM_QUALITY_CLASS_CD COMMENT 'NFPO code for item_1 quality classification\nCBX: CNT_ITEM.LDL_ARTICLE_CLASS',
	MDM_PILLAR_SID COMMENT 'surrogate key, identifier of the pillar in NFPO source system, alternative item_1 grouping for non food items in addition to the standard grouping based on item_1 families\nCBX: CNT_ITEM.LDL_PILLAR',
	MAIN_PILLAR_CD COMMENT 'main pillar code  (TX/HG) \nCBX: CNT_ITEM.PRODUCT_CATEGORY_VALUE',
	MDM_CUST_NEED_TYPE_CD COMMENT 'Code to classify the assortment by general customer needs.\nCBX: CNT_ITEM.LDL_FOCUS_CATEGORY',
	MDM_CUST_NEED_SUBTYPE_CD COMMENT 'Code to classify the assortment by detailed customer needs.\nCBX: CNT_ITEM.LDL_CATEGORY_NEEDS',
	CORE_ASSORT_TYPE_CD COMMENT 'Code  of the type how the item_1 can be regarded to be part of the Lidl core assortment.\nCBX: CNT_ITEM.ldl_core_article',
	ASSORT_PROFILE_TYPE_CD COMMENT 'Code to indicate the importance profile of the item_1 in the assortment (Pflicht, Profilierung, Ergänzung).\nCBX: CNT_ITEM.LDL_FMS_ASSORTMENT',
	KFL_BRAND_SID COMMENT 'surrogate key, identifies the brand_1 in case of selling in a Kaufland country_1\nCBX: CNT_ITEM.LDL_BRAND_KL',
	MDM_ITEM_SPLIT_ROLE_CD COMMENT 'NFPO code for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (\""Vereinzelung\"")\nCBX: CNT_ITEM.LDL_PARENT_OR_CHILD',
	MDM_LIST_TYPE_CD COMMENT 'NFPO codes for list types of items\nCBX: CNT_ITEM.LDL_ASSORT_TYPE',
	MDM_ITEM_SPLIT_METHOD_CD COMMENT 'NFPO code for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (\""Vereinzelung\"")\nCBX: CNT_ITEM.LDL_STYLE_SPLIT',
	INNOVATION_FG COMMENT 'indicates whether an item_1 is an innovation article (1) or not (0) \nCBX: CNT_ITEM.LDL_INNOVATION_ART',
	SEASON_NAME COMMENT 'name of the season in case of a season relaterd item_1\nCBX: CNT_ITEM.SEASON',
	CATALOG_FG COMMENT 'indicator whether an item_1 is a catalog item_1 or not, catalog items will get extra item_1 instances for every range selection where they are valid. The conditions and proterties remain unchanged.\nCBX: CNT_ITEM.LDL_CAT_INDICATOR',
	CANCEL_REASON_NAME COMMENT 'cancellation reason name if the item_1 has been cancelled\nCBX: CNT_ITEM.LDL_CANCELLATION_REASON',
	INITIAL_RANGE_PLAN_CD COMMENT 'initial charge ot the item_1\nCBX: CNT_ITEM.LDL_INITIAL_LOT_NO',
	LDL_RELEVANT_FG COMMENT 'indicates whethter this item_1 is relevant to be sold by Lidl\nCBX: CNT_ITEM.LDL_NO_LIDL_ITEM',
	KFL_RELEVANT_FG COMMENT 'indicates whethter this item_1 is relevant to be sold by Kaufland\nCBX: CNT_ITEM.LDL_KL_DECISION',
	PACKAGE_TYPE_CD COMMENT 'NFPO outer package_1 type codes for items\nCBX: CNT_ITEM.LDL_PACKING_TYPE',
	CONTROLLED_PRICE_FG COMMENT 'indicates wheter the price is controlled outside NFPO\nCBX: CNT_ITEM.LDL_BINDING_PRICE',
	ITEM_HIGHLIGHT_FG COMMENT 'Indicates whether the item_1 should be placed prominently during the internal trade show\nCBX: CNT_ITEM.LDL_BRIEF_HIGHLIGHT',
	INITIAL_ORDER_FG COMMENT 'Indicator whether this item_1 instance initiates the first order for an catalog item_1\nCBX: CNT_ITEM.LDL_INITIAL_ORDER',
	ITEM_UNIT_UOM_SID COMMENT 'indicator in the item_1 planning process: surrogate key item_1 content unit_1 of measurement. interpretation depends on the overall composition of the item_1 \nCBX: CNT_ITEM.LDL_CONTAINER_UNIT',
	ITEM_UNIT_UOM_CD COMMENT 'indicator in the item_1 planning process: code of the item_1 content unit_1 of measurement. interpretation depends on the overall composition of the item_1\nCBX: CNT_ITEM.LDL_CONTAINER_UNIT',
	ITEM_UNIT_QTY COMMENT 'indicator in the item_1 planning process: quantity of the content of units of the item. interpretation depends on the overall composition of the item_1 \nCBX: CNT_ITEM.LDL_CONTAINER_VOLUME',
	ITEM_UNIT_CNT COMMENT 'indicator in the item_1 planning process: number of units the item_1 consists of for the main variant. interpretation depends on the overall composition of the item_1 \nCBX: CNT_ITEM.LDL_NUMBER_OF_CONTAINER',
	MINIMAL_ORDER_QTY COMMENT 'minimum of the order quantity for a catalog item_1\nCBX: CNT_ITEM.LDL_MOQ',
	ITEM_INITIATING_INT_ORG_SID COMMENT 'organisation which initiates the item_1 due to competitor items\nCBX: CNT_ITEM.LDL_STORE_CHECK_NAME',
	ITEM_PROPOSING_INT_ORG_SID COMMENT 'organisation which did propose this item_1\nCBX: CNT_ITEM.LDL_COUNTRY_PROPOSAL',
	CASE_SIZE_QTY COMMENT 'predefined number of items in the sort boxes of the item. all sort boxes will have the same case_size_qty. \nCBX: CNT_ITEM.LDL_UNIT_OF_CARTON',
	CONTRACT_EXPIRY_DT COMMENT 'for catalog items here the expiry date of the contract is stored\nCBX: CNT_ITEM.LDL_CONTRACT_EXPIRY_DATE',
	MDM_ITEM_COMPOSITION_CD COMMENT 'indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig\nCBX:CNT_ITEM.LDL_ASSORTMENT',
	ITEM_VARIANT_CNT COMMENT 'indicator in the item_1 planning process: number of relevant variants the item_1 the item_1 has from the design point of view. interpretation depends on the overall composition of the item_1 \nCBX: CNT_ITEM.LDL_NUM_OF_UNITS',
	MDM_CASE_COMPOSITION_CD COMMENT 'indicator in the item_1 planning process: indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items. interpretation depends on the overall composition of the item_1 \nCBX:CNT_ITEM.LDL_PACK_TYPE',
	QUALITY_COMMENT_TXT COMMENT 'free text remark related to the NFPO item_1 from the quality development team point of view\nCBX: CNT_ITEM.LDL_REMARK_QE',
	PURCH_COMMENT_TXT COMMENT 'free text remark related to the NFPO item_1 from the purchasing team point of view\nCBX: CNT_ITEM.LDL_REMARK_EK',
	MDM_SMART_ITEM_FG COMMENT 'The flag indicates whether an item_1 is regarded to be a smart item_1 or not.\nThe definition of a smart item_1 is not standardized. It can be an IOT item_1 or have connectivity / networking capabilities. Items whose networking capability is a central component of their use, like a printer, may not be considered smart items.\nCBX: CNT_ITEM.LDL_IOT',
	MDM_LOGISTICS_CLASS_CD COMMENT 'Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.\nCBX: CNT_ITEM.LDL_DELIVERY_TYPE',
	MDM_LDL_SALES_PACKAGING_TYPE_CD COMMENT 'Code of the sales_1 packaging type to be used for sales_1 in the line of business Lidl.\nCBX: CNT_ITEM.LDL_RETAIL_PACKAGING',
	MDM_KFL_SALES_PACKAGING_TYPE_CD COMMENT 'Code of the sales_1 packaging type to be used for sales_1 in the line of business Kaufland.\nCBX: CNT_ITEM.LDL_RETAIL_PACKAGING_KL',
	EU_DATA_ACT_RELEVANT_FG COMMENT 'The flag indicates whether an item_1 is relevant for EU Data act or not.\nCBX:CNT_ITEM.LDL_EU_DATA_ACT',
	DELETED_FG COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
	DWH_VALID_FROM COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) as SELECT
   client_id
  ,mdm_item_sid
  ,cbx_item_version_nr
  ,cbx_item_doc_status
  ,cbx_item_created_tmsp
  ,cbx_item_change_tmsp
  ,market_sid
  ,item_fam_grp_sid
  ,brand_sid
  ,country_pol_sid_origin
  ,mdm_sup_sid
  ,ean_ownership_cd
  ,sup_final_fg
  ,item_workflow_status_id
  ,item_class_cd
  ,buy_status_cd
  ,display_type_cd
  ,hier_node_sid
  ,item_collection
  ,item_notes
  ,guarantee_cd
  ,guarantee_type_cd
  ,guarantee_art
  ,item_quality_class_cd
  ,mdm_pillar_sid
  ,main_pillar_cd
  ,mdm_cust_need_type_cd
  ,mdm_cust_need_subtype_cd
  ,core_assort_type_cd
  ,assort_profile_type_cd
  ,kfl_brand_sid
  ,mdm_item_split_role_cd
  ,mdm_list_type_cd
  ,mdm_item_split_method_cd
  ,innovation_fg
  ,season_name
  ,catalog_fg
  ,cancel_reason_name
  ,initial_range_plan_cd
  ,ldl_relevant_fg
  ,kfl_relevant_fg
  ,package_type_cd
  ,controlled_price_fg
  ,item_highlight_fg
  ,initial_order_fg
  ,item_unit_uom_sid
  ,item_unit_uom_cd
  ,item_unit_qty
  ,item_unit_cnt
  ,minimal_order_qty
  ,item_initiating_int_org_sid
  ,item_proposing_int_org_sid
  ,case_size_qty
  ,contract_expiry_dt
  ,mdm_item_composition_cd
  ,item_variant_cnt
  ,mdm_case_composition_cd
  ,quality_comment_txt
  ,purch_comment_txt
  ,mdm_smart_item_fg
  ,mdm_logistics_class_cd
  ,mdm_ldl_sales_packaging_type_cd
  ,mdm_kfl_sales_packaging_type_cd
  ,eu_data_act_relevant_fg
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_MDM_ITEM_HIST_1
;
