CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_LOCAL_PRODUCT_2(
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the country_2 organization.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LOCAL_PROD_NR COMMENT 'The number which identifies the product within the given market / internal organization. (i.e. the local item_2 number)  Note that the product number is unique for a certain point in time, but may be re_2-used later on.',
	ALT_1_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the first additional product number.',
	ALT_2_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the second additional product number.',
	ALT_3_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the third additional product number.',
	ALT_4_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the forth additional product number.',
	ALT_5_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the fifth additional product number.',
	ALT_6_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the sixth additional product number.',
	ALT_7_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the seventh additional product number.',
	ALT_8_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the eight additional product number.',
	ALT_9_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the ninth additional product number.',
	ALT_10_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the tenth additional product number.',
	ALT_11_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the eleventh additional product number.',
	ALT_12_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the twelveth additional product number.',
	ALT_13_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the thirteenth additional product number.',
	ALT_14_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the forteenth additional product number.',
	ALT_15_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the fifteenth additional product number.',
	ALT_16_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the sixteenth additional product number.',
	ALT_17_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the seventeenth additional product number.',
	ALT_18_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the eighteenth additional product number.',
	ALT_19_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the nineteenth additional product number.',
	ALT_20_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is the twentieth additional product number.',
	ALT_LOCAL_PROD_NR COMMENT 'A product may be identified by more than one product number within a country_2 organization. In this case, this is combination of all additional product numbers.',
	ALT_LOCAL_PROD_NR_CNT COMMENT 'A product may be identified by more than one product number within a country_2 organization. This is the total number of additional product numbers that exist in the given country_2 organization. (Note that only the first five product numbers are stored in the columns alt_<n>_local_prod_nr.)',
	LOCAL_PROD_NAME COMMENT 'The name by which the product is marketed within the given market / internal organization. (This is the local product name.)',
	LOCAL_PROD_DESCR COMMENT 'A more detailed (free text) description for the product - which applies to the given market / internal organization.',
	LOCAL_PROD_VERSION_NR COMMENT 'The version number of the product in the given market / internal company.',
	LOCAL_PROD_CREATION_DT COMMENT 'The date when the product was created in the operational system for the given market / internal company.',
	PLU_NR COMMENT 'Price Lookup Code; a 4 or 5 digit code to identify items, used mostly for fruits and vegetables.',
	PROD_STATUS_CD COMMENT 'The code for the status_2 for products, as defined by the retail system.',
	PROD_STATUS_DESCR COMMENT 'A textual description for the status_2 for products, as defined by the retail system. (Description in group language, i.e. in German)',
	BRAND_TYPE_CD COMMENT 'A code that identifies the brand_2 type. (own brand_2 vs. private brand_2)',
	BRAND_TYPE_DESCR COMMENT 'A textual description for the brand_2 type (own brand_2 vs. private brand_2) in group language, i.e.in German.',
	BRAND_NAME COMMENT 'The name of the brand.',
	SUP_SID COMMENT 'The unique identifier (surrogate key) for the supplier_2 of this product for the given country_2 organization.',
	SUP_NAME COMMENT 'The name by which the supplier_2 is known.',
	BUYER_SID COMMENT 'The unique identifier (surrogate key) for the employee_2, who negotiated this product for the given country_2 organization.',
	BUYER_NR COMMENT 'The number which identifies the buyer within the organization.',
	LOCAL_LIST_DT COMMENT 'The date when the product was first listed in the given market / internal company.',
	LOCAL_DELIST_DT COMMENT 'The date when the product was removed from the assortment in the given market / internal company.',
	INTRASTAT_NR COMMENT 'The Intrastat number which identifies a certain class of products.',
	INTRASTAT_NAME COMMENT 'The name for the Intrastat number. This is the eight-digit number. (Name in group language, i.e. in German)',
	LOCKED_FG COMMENT 'An indicator showing, if the product has been locked for the given market / internal company. In that case the product cannot be sold, but may still be returned.',
	VAT_REFUND_FG COMMENT 'An indicator showing, if the product is elegible for VAT refund in the given market.',
	DANGEROUS_GOODS_FG COMMENT 'An indicator for hazardous material.',
	COUNTRY_SPECIFIC_PROD_FG COMMENT 'An indicator showing, if the underlying product has been defined by only one country_2 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.) On product variant level this means, that this is the only variant of the product.',
	DISPATCH_GRP_NR COMMENT 'The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.',
	DISPATCH_GRP_DESCR COMMENT 'A textual description for the dispatch group. (Description in group language, i.e. in German)',
	DISPATCH_UNIT_CD COMMENT 'The code identifying the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.',
	DISPATCH_UNIT_DESCR COMMENT 'A textual description for the unit_2 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc. (Description in group language, i.e. in German)',
	LIST_TYPE_CD COMMENT 'The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.',
	LIST_TYPE_DESCR COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in group language, i.e. in German)',
	ORDER_AREA_NR COMMENT 'The number which identifies the order area.',
	ORDER_AREA_DESCR COMMENT 'A textual description for the order area. (Description in group language, i.e. in German)',
	MIN_CUST_AGE_MEAS COMMENT 'The minimum age for a customer who wants to purchase this product.',
	SORT_SEQ COMMENT 'The sort order of the product on lists. The sort order is relative to the item_2 family of the product.',
	MIN_CONSUMPTION_DAY_CNT COMMENT 'The minimum amount of life (in number of days) an item_2 must have remaining when bought by a customer.',
	MIN_SHELFLIFE_TO_STORE_DAY_CNT COMMENT 'The minimum amount of shelf life (in number of days) an item_2 must have remaining when delivered to a store.',
	MIN_SHELFLIFE_TO_WH_DAY_CNT COMMENT 'The minimum amount of life (in number of days) an item_2 must have remaining when delivered to the warehouse.',
	DELIV_TEMP_MEAS COMMENT 'The (recommended) delivery temperature for the product.',
	MIN_DELIV_TEMP_MEAS COMMENT 'The minimum delivery temperature for the product.',
	MAX_DELIV_TEMP_MEAS COMMENT 'The maximum delivery temperature for the product.',
	UOM_CD COMMENT 'The code identifying the unit_2 of measure.',
	SHELFLIFE_CHECK_ON_RECEIPT_FG COMMENT 'An indicator showing, if the minimum shelflife for this product shall be checked upon receipt.',
	ITEM_FAM_SID COMMENT 'The unique identifier (surrogate key) for the item_2 family to which this product belongs.',
	ITEM_FAM_NR COMMENT 'The number by which the related item_2 family is known to business.',
	ITEM_FAM_NAME COMMENT 'The name of the related item_2 family in group language, i.e. in German.',
	SUB_ITEM_GRP_SID COMMENT 'The unique identifier (surrogate key) for a sub item_2 group to which this product belongs.',
	SUB_ITEM_GRP_NR COMMENT 'The number by which the related sub item_2 group is known to business.',
	SUB_ITEM_GRP_NAME COMMENT 'The name of the related sub item_2 group in group language, i.e. in German.',
	INT_ITEM_GRP_SID COMMENT 'The unique identifier [surrogate key] for an international item_2 group to which this product belongs.',
	INT_ITEM_GRP_NR COMMENT 'The number by which the related international item_2 group is known to business.',
	INT_ITEM_GRP_NAME COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
	PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the pillar, to which this product belongs.',
	PILLAR_NR COMMENT 'The number by which the related pillar is known to business.',
	PILLAR_NAME COMMENT 'The name of the related pillar in group language, i.e. in German.',
	MAIN_PILLAR_SID COMMENT 'The unique identifier (surrogate key) for the top pillar, to which this product belongs.',
	MAIN_PILLAR_NR COMMENT 'The number by which the related top pillar is known to business.',
	MAIN_PILLAR_NAME COMMENT 'The name of the related top pillar in group language, i.e. in German.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This dimension contains the properties of a product, as they are defined by a country_2 organization.'
 AS SELECT
  main.prod_sid AS prod_sid
, main.country_org_sid AS country_org_sid
, main.country_org_cd AS country_org_cd
, main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
, main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
, main.dwh_valid_fg AS dwh_valid_fg
, main.local_prod_nr AS local_prod_nr
, main.alt_1_local_prod_nr AS alt_1_local_prod_nr
, main.alt_2_local_prod_nr AS alt_2_local_prod_nr
, main.alt_3_local_prod_nr AS alt_3_local_prod_nr
, main.alt_4_local_prod_nr AS alt_4_local_prod_nr
, main.alt_5_local_prod_nr AS alt_5_local_prod_nr
, main.alt_6_local_prod_nr AS alt_6_local_prod_nr
, main.alt_7_local_prod_nr AS alt_7_local_prod_nr
, main.alt_8_local_prod_nr AS alt_8_local_prod_nr
, main.alt_9_local_prod_nr AS alt_9_local_prod_nr
, main.alt_10_local_prod_nr AS alt_10_local_prod_nr
, main.alt_11_local_prod_nr AS alt_11_local_prod_nr
, main.alt_12_local_prod_nr AS alt_12_local_prod_nr
, main.alt_13_local_prod_nr AS alt_13_local_prod_nr
, main.alt_14_local_prod_nr AS alt_14_local_prod_nr
, main.alt_15_local_prod_nr AS alt_15_local_prod_nr
, main.alt_16_local_prod_nr AS alt_16_local_prod_nr
, main.alt_17_local_prod_nr AS alt_17_local_prod_nr
, main.alt_18_local_prod_nr AS alt_18_local_prod_nr
, main.alt_19_local_prod_nr AS alt_19_local_prod_nr
, main.alt_20_local_prod_nr AS alt_20_local_prod_nr
, COALESCE(main.alt_1_local_prod_nr,'')||DECODE(main.alt_2_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_2_local_prod_nr,'')||DECODE(main.alt_3_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_3_local_prod_nr,'')||DECODE(main.alt_4_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_4_local_prod_nr,'')||DECODE(main.alt_5_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_5_local_prod_nr,'')||DECODE(main.alt_6_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_6_local_prod_nr,'')||DECODE(main.alt_7_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_7_local_prod_nr,'')||DECODE(main.alt_8_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_8_local_prod_nr,'')||DECODE(main.alt_9_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_9_local_prod_nr,'')||DECODE(main.alt_10_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_10_local_prod_nr,'')||DECODE(main.alt_11_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_11_local_prod_nr,'')||DECODE(main.alt_12_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_12_local_prod_nr,'')||DECODE(main.alt_13_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_13_local_prod_nr,'')||DECODE(main.alt_14_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_14_local_prod_nr,'')||DECODE(main.alt_15_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_15_local_prod_nr,'')||DECODE(main.alt_16_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_16_local_prod_nr,'')||DECODE(main.alt_17_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_17_local_prod_nr,'')||DECODE(main.alt_18_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_18_local_prod_nr,'')||DECODE(main.alt_19_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_19_local_prod_nr,'')||DECODE(main.alt_20_local_prod_nr,NULL,'','|')||
  COALESCE(main.alt_20_local_prod_nr,'') AS ALT_LOCAL_PROD_NR
, main.alt_local_prod_nr_cnt AS alt_local_prod_nr_cnt
, main.local_prod_name AS local_prod_name
, main.local_prod_descr AS local_prod_descr
, main.local_prod_version_nr AS local_prod_version_nr
, main.local_prod_creation_dt AS local_prod_creation_dt
, main.plu_nr AS plu_nr
, main.prod_status_cd AS prod_status_cd
, main.prod_status_descr AS prod_status_descr
, main.brand_type_cd AS brand_type_cd
, main.brand_type_descr AS brand_type_descr
, main.brand_name AS brand_name
, main.sup_sid AS sup_sid
, main.sup_name AS sup_name
, main.buyer_sid AS buyer_sid
, main.buyer_nr AS buyer_nr
, main.local_list_dt AS local_list_dt
, main.local_delist_dt AS local_delist_dt
, main.intrastat_nr AS intrastat_nr
, main.intrastat_name AS intrastat_name
, main.locked_fg AS locked_fg
, main.vat_refund_fg AS vat_refund_fg
, main.dangerous_goods_fg AS dangerous_goods_fg
, main.country_specific_prod_fg AS country_specific_prod_fg
, main.dispatch_grp_nr AS dispatch_grp_nr
, main.dispatch_grp_descr AS dispatch_grp_descr
, main.dispatch_unit_cd AS dispatch_unit_cd
, main.dispatch_unit_descr AS dispatch_unit_descr
, main.list_type_cd AS list_type_cd
, main.list_type_descr AS list_type_descr
, main.order_area_nr AS order_area_nr
, main.order_area_descr AS order_area_descr
, main.min_cust_age_meas AS min_cust_age_meas
, main.sort_seq AS sort_seq
, main.min_consumption_day_cnt AS min_consumption_day_cnt
, main.min_shelflife_to_store_day_cnt AS min_shelflife_to_store_day_cnt
, main.min_shelflife_to_wh_day_cnt AS min_shelflife_to_wh_day_cnt
, main.deliv_temp_meas AS deliv_temp_meas
, main.min_deliv_temp_meas AS min_deliv_temp_meas
, main.max_deliv_temp_meas AS max_deliv_temp_meas
, main.uom_cd AS uom_cd
, main.shelflife_check_on_receipt_fg AS shelflife_check_on_receipt_fg
, main.item_fam_sid AS item_fam_sid
, main.item_fam_nr AS item_fam_nr
, main.item_fam_name AS item_fam_name
, main.sub_item_grp_sid AS sub_item_grp_sid
, main.sub_item_grp_nr AS sub_item_grp_nr
, main.sub_item_grp_name AS sub_item_grp_name
, main.int_item_grp_sid AS int_item_grp_sid
, main.int_item_grp_nr AS int_item_grp_nr
, main.int_item_grp_name AS int_item_grp_name
, main.pillar_sid AS pillar_sid
, main.pillar_nr AS pillar_nr
, main.pillar_name AS pillar_name
, main.main_pillar_sid AS main_pillar_sid
, main.main_pillar_nr AS main_pillar_nr
, main.main_pillar_name AS main_pillar_name
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
 FROM CORE_DIM.T_DIM_LOCAL_PRODUCT_2 main WHERE main.dwh_valid_fg;