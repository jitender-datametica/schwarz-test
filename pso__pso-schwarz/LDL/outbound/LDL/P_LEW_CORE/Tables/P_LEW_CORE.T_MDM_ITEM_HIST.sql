/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_hist
   generated from Powerdesigner on Montag, 1. Dezember 2025 12:29:21
*/ --------------------------------------------------------------------------------



CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical column required by the used ETL framework. Static 7 for all rows.'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key NFPO item instance
            CBX: CNT_ITEM.REF_NO'''),
cbx_item_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''technical version of the NFPO item in the source system
            CBX: CNT_ITEM.VERSION'''),
cbx_item_doc_status STRING(100) COLLATE 'und:ci'
OPTIONS(description='''technical status of the NFPO item in the source system (active,inactive,cancelled)
            CBX: CNT_ITEM.DOC_STATUS'''),
cbx_item_created_tmsp DATETIME NOT NULL
OPTIONS(description='''creation timestamp of NFPO item instance record in the source system
            CBX: CNT_ITEM.CREATED_ON'''),
cbx_item_change_tmsp DATETIME NOT NULL
OPTIONS(description='''change timestamp of NFPO item instance record in the source system
            CBX: CNT_ITEM.UPDATED_ON'''),
market_sid BIGNUMERIC(38,0)
OPTIONS(description='''foreign key NFPO market
            CBX: CNT_ITEM.LDL_CONTINENT_TYPE'''),
item_fam_grp_sid BIGNUMERIC(38,0)
OPTIONS(description='''foreign key item family group
            CBX: CNT_ITEM.LDL_ARTICLE_GROUP'''),
brand_sid BIGNUMERIC(38,0) OPTIONS(description='''foreign key brand
            CBX: CNT_ITEM.LDL_BRAND'''),
country_pol_sid_origin BIGNUMERIC(38,0)
OPTIONS(description='''foreign key political country, here the manufacturing country of the item is used
            CBX: CNT_ITEM.LDL_COUNTRY_OF_ORIGIN'''),
mdm_sup_sid BIGNUMERIC(38,0)
OPTIONS(description='''foreign key NFPO supplier
            CBX: CNT_ITEM.LDL_DEFAULT_VENDOR_REF'''),
ean_ownership_cd STRING(100)
OPTIONS(description='''NFPO GTIN assignement responisbility code
            CBX: CTM_VENDOR.CUST_CODELIST1'''),
sup_final_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicated whether the supplier is finally fixed
            CBX: CNT_ITEM.LDL_FINAL_VENDOR'''),
item_workflow_status_id BIGNUMERIC(38,0)
OPTIONS(description='''foreign key NFPO item workflow status
            CBX: CNT_ITEM.STATUS substringAfter("customStatus")'''),
item_class_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='''NFPO item classification code related to item creation and usage over time
            CBX: CNT_ITEM.LDL_ARTICLE_TYPE'''),
buy_status_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='''NFPO status code related to the order quantity definition process for the local NFPOs of items
            CBX: CNT_ITEM.LDL_COUNTRY_ORDER_STATUS'''),
display_type_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='''NFPO display type code
            CBX: CNT_ITEM.LDL_DISPLAY_TYPE'''),
hier_node_sid BIGNUMERIC(38,0)
OPTIONS(description='''FK Node
            CBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE'''),
item_collection STRING(300)
OPTIONS(description='''Item collection (related group of articles, free text)
            CBX: CNT_ITEM.LDL_ITEM_COLLECTION'''),
item_notes STRING(4000) OPTIONS(description='''Item procurement notes;
            CBX: CNT_ITEM.LDL_EK_NOTE'''),
guarantee_cd STRING(100) OPTIONS(description='''NFPO warranty duration code
            CBX: CNT_ITEM.LDL_GUARANTEE'''),
guarantee_type_cd STRING(100)
OPTIONS(description='''NFPO warranty type code
            CBX: CNT_ITEM.LDL_WARRANTY_ART_TYPE'''),
guarantee_art STRING(4000) COLLATE 'und:ci'
OPTIONS(description='''NFPO warranty type long description
            CBX: CNT_ITEM.LDL_ART'''),
item_quality_class_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='''NFPO code for item quality classification
            CBX: CNT_ITEM.LDL_ARTICLE_CLASS'''),
mdm_pillar_sid BIGNUMERIC(38,0)
OPTIONS(description='''surrogate key, identifier of the pillar in NFPO source system, alternative item grouping for non food items in addition to the standard grouping based on item families
            CBX: CNT_ITEM.LDL_PILLAR'''),
main_pillar_cd STRING(100)
OPTIONS(description='''main pillar code  (TX/HG) 
            CBX: CNT_ITEM.PRODUCT_CATEGORY_VALUE'''),
mdm_cust_need_type_cd STRING(100)
OPTIONS(description='''Code to classify the assortment by general customer needs.
            CBX: CNT_ITEM.LDL_FOCUS_CATEGORY'''),
mdm_cust_need_subtype_cd STRING(100)
OPTIONS(description='''Code to classify the assortment by detailed customer needs.
            CBX: CNT_ITEM.LDL_CATEGORY_NEEDS'''),
core_assort_type_cd STRING(100)
OPTIONS(description='''Code  of the type how the item can be regarded to be part of the Lidl core assortment.
            CBX: CNT_ITEM.ldl_core_article'''),
assort_profile_type_cd STRING(100)
OPTIONS(description='''Code to indicate the importance profile of the item in the assortment (Pflicht, Profilierung, Ergänzung).
            CBX: CNT_ITEM.LDL_FMS_ASSORTMENT'''),
kfl_brand_sid BIGNUMERIC(38,0)
OPTIONS(description='''surrogate key, identifies the brand in case of selling in a Kaufland country
            CBX: CNT_ITEM.LDL_BRAND_KL'''),
mdm_item_split_role_cd STRING(100)
OPTIONS(description='''NFPO code for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item granularity requirements in Kaufland compared to Lidl ("Vereinzelung")
            CBX: CNT_ITEM.LDL_PARENT_OR_CHILD'''),
mdm_list_type_cd STRING(100)
OPTIONS(description='''NFPO codes for list types of items
            CBX: CNT_ITEM.LDL_ASSORT_TYPE'''),
mdm_item_split_method_cd STRING(100)
OPTIONS(description='''NFPO code for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item granularity requirements in Kaufland compared to Lidl ("Vereinzelung")
            CBX: CNT_ITEM.LDL_STYLE_SPLIT'''),
innovation_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates whether an item is an innovation article (1) or not (0) 
            CBX: CNT_ITEM.LDL_INNOVATION_ART'''),
season_name STRING(100)
OPTIONS(description='''name of the season in case of a season relaterd item
            CBX: CNT_ITEM.SEASON'''),
catalog_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicator whether an item is a catalog item or not, catalog items will get extra item instances for every range selection where they are valid. The conditions and proterties remain unchanged.
            CBX: CNT_ITEM.LDL_CAT_INDICATOR'''),
cancel_reason_name STRING(100)
OPTIONS(description='''cancellation reason name if the item has been cancelled
            CBX: CNT_ITEM.LDL_CANCELLATION_REASON'''),
initial_range_plan_cd STRING(20)
OPTIONS(description='''initial charge ot the item
            CBX: CNT_ITEM.LDL_INITIAL_LOT_NO'''),
ldl_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates whethter this item is relevant to be sold by Lidl
            CBX: CNT_ITEM.LDL_NO_LIDL_ITEM'''),
kfl_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates whethter this item is relevant to be sold by Kaufland
            CBX: CNT_ITEM.LDL_KL_DECISION'''),
package_type_cd STRING(100)
OPTIONS(description='''NFPO outer package type codes for items
            CBX: CNT_ITEM.LDL_PACKING_TYPE'''),
controlled_price_fg BIGNUMERIC(38,0)
OPTIONS(description='''indicates wheter the price is controlled outside NFPO
            CBX: CNT_ITEM.LDL_BINDING_PRICE'''),
item_highlight_fg BIGNUMERIC(38,0)
OPTIONS(description='''Indicates whether the item should be placed prominently during the internal trade show
            CBX: CNT_ITEM.LDL_BRIEF_HIGHLIGHT'''),
initial_order_fg BIGNUMERIC(38,0)
OPTIONS(description='''Indicator whether this item instance initiates the first order for an catalog item
            CBX: CNT_ITEM.LDL_INITIAL_ORDER'''),
item_unit_uom_sid BIGNUMERIC(38,0)
OPTIONS(description='''indicator in the item planning process: surrogate key item content unit of measurement. interpretation depends on the overall composition of the item 
            CBX: CNT_ITEM.LDL_CONTAINER_UNIT'''),
item_unit_uom_cd STRING(100)
OPTIONS(description='''indicator in the item planning process: code of the item content unit of measurement. interpretation depends on the overall composition of the item
            CBX: CNT_ITEM.LDL_CONTAINER_UNIT'''),
item_unit_qty BIGNUMERIC(38,5)
OPTIONS(description='''indicator in the item planning process: quantity of the content of units of the item. interpretation depends on the overall composition of the item 
            CBX: CNT_ITEM.LDL_CONTAINER_VOLUME'''),
item_unit_cnt BIGNUMERIC(38,0)
OPTIONS(description='''indicator in the item planning process: number of units the item consists of for the main variant. interpretation depends on the overall composition of the item 
            CBX: CNT_ITEM.LDL_NUMBER_OF_CONTAINER'''),
minimal_order_qty BIGNUMERIC(38,5)
OPTIONS(description='''minimum of the order quantity for a catalog item
            CBX: CNT_ITEM.LDL_MOQ'''),
item_initiating_int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''organisation which initiates the item due to competitor items
            CBX: CNT_ITEM.LDL_STORE_CHECK_NAME'''),
item_proposing_int_org_sid BIGNUMERIC(38,0)
OPTIONS(description='''organisation which did propose this item
            CBX: CNT_ITEM.LDL_COUNTRY_PROPOSAL'''),
case_size_qty BIGNUMERIC(38,5)
OPTIONS(description='''predefined number of items in the sort boxes of the item. all sort boxes will have the same case_size_qty. 
            CBX: CNT_ITEM.LDL_UNIT_OF_CARTON'''),
contract_expiry_dt DATE
OPTIONS(description='''for catalog items here the expiry date of the contract is stored
            CBX: CNT_ITEM.LDL_CONTRACT_EXPIRY_DATE'''),
mdm_item_composition_cd STRING(100)
OPTIONS(description='''indicator in the item planning process: indicates whether an item has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:CNT_ITEM.LDL_ASSORTMENT'''),
item_variant_cnt BIGNUMERIC(38,0)
OPTIONS(description='''indicator in the item planning process: number of relevant variants the item the item has from the design point of view. interpretation depends on the overall composition of the item 
            CBX: CNT_ITEM.LDL_NUM_OF_UNITS'''),
mdm_case_composition_cd STRING(100)
OPTIONS(description='''indicator in the item planning process: indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items. interpretation depends on the overall composition of the item 
            CBX:CNT_ITEM.LDL_PACK_TYPE'''),
quality_comment_txt STRING(1000)
OPTIONS(description='''free text remark related to the NFPO item from the quality development team point of view
            CBX: CNT_ITEM.LDL_REMARK_QE'''),
purch_comment_txt STRING(1000)
OPTIONS(description='''free text remark related to the NFPO item from the purchasing team point of view
            CBX: CNT_ITEM.LDL_REMARK_EK'''),
mdm_smart_item_fg BIGNUMERIC(38,0)
OPTIONS(description='''The flag indicates whether an item is regarded to be a smart item or not.
            The definition of a smart item is not standardized. It can be an IOT item or have connectivity / networking capabilities. Items whose networking capability is a central component of their use, like a printer, may not be considered smart items.
            CBX: CNT_ITEM.LDL_IOT'''),
mdm_logistics_class_cd STRING(100)
OPTIONS(description='''Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
            CBX: CNT_ITEM.LDL_DELIVERY_TYPE'''),
mdm_ldl_sales_packaging_type_cd STRING(100)
OPTIONS(description='''Code of the sales packaging type to be used for sales in the line of business Lidl.
            CBX: CNT_ITEM.LDL_RETAIL_PACKAGING'''),
mdm_kfl_sales_packaging_type_cd STRING(100)
OPTIONS(description='''Code of the sales packaging type to be used for sales in the line of business Kaufland.
            CBX: CNT_ITEM.LDL_RETAIL_PACKAGING_KL'''),
eu_data_act_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='''The flag indicates whether an item is relevant for EU Data act or not.
            CBX:CNT_ITEM.LDL_EU_DATA_ACT'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='''Instances of NFPO items in the quarterly item planning and ordering process. For catalog items there might be several instances in this table, all sharing the same international article number.
             CBX: CNT_ITEM''');


