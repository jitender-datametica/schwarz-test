create or replace view LDL_PRODUCTION.P_LEW_MART_LEAD.V_ITM_ITEM_1(
	BRAND_1,
	BUYING_LIST_ORDERSET_NR,
	CASE_SIZE,
	CLIENT_ID,
	COUNTRY_CD,
	DAT_VALID_FROM,
	ITEM_ID,
	ORIG_ITEM_NR,
	ORIG_ITEM_NR_INT,
	ADD_DOCS_FG,
	ADDITIONS,
	AGE_FG,
	BEVERAGE_TAX,
	BUYER_ID,
	BUYER_NAME,
	BUYING_LIST_TYPE_ID,
	BUYING_LIST_TYPE_DESC,
	BRAND_TYPE_ID COMMENT 'the type of brand_1 of an article (1=m, 2=em, 3=hm)',
	LISTING_TYPE_ID COMMENT 'the type of listing article (1=aktions-artikel_1, 2=ausgelistet, 3=neu-einlistung, 4=normalsortiment, 5=saison-artikel_1, 6=test_1-artikel_1)',
	CASE_DD,
	CASE_DEPTH,
	CASE_EURO,
	CASE_HEIGHT,
	CASE_LAYER,
	CASE_PLU_FG,
	CASE_VOLUME,
	CASE_WEIGHT,
	CASE_WIDTH,
	COMMODITY_CD,
	CONSUMPTION_TAX_MAIN_ID,
	CONSUMPTION_TAX_SUB_ID,
	CONT_DEPOSIT_ITEM_NR,
	CONTRACT_COUNTRY_CD,
	DANGEROUS_GOODS_FG,
	DAT_ADV,
	DAT_DELISTING,
	DAT_LISTING,
	DAT_MIN_SHELFLIFETEST_FG,
	DELISTING_FG,
	DELIVERY_TEMP,
	DIRECT_DELETE_MDE_FG,
	DISCOUNT_FG,
	DUALSYSTEM_FG,
	DUR_SHELFLIFE_DAY_CUST,
	DUR_SHELFLIFE_DAY_STORE,
	DUR_SHELFLIFE_DAY_WH,
	FOOD_FG,
	FORWARDING_ITEM_NR,
	INT_SUBITEMGROUP_ID,
	ITEM_ACTIONGROUP_ID,
	ITEM_FAMILYGROUP_ID,
	ITEM_PARTS,
	ITEM_PARTS_CD,
	ITEM_PLU_NR,
	ITEM_SHORT_DESC_1,
	ITEM_SHORT_DESC_2,
	ITEM_SHORT_DESC_3,
	ITEM_SUB_ACTIONGROUP_ID,
	ITEM_TEXT_1,
	ITEM_TEXT_2,
	ITEM_TEXT_3,
	ITEM_VERSION,
	LIDL_BUYING_COUNTRY_CD,
	LISTING_FG,
	LOGISTIC_UNIT_CD,
	MAX_RECEIVE_TEMP,
	MDESSP_FG,
	MDM_CUST_NEED_SUBTYPE_CD COMMENT 'Code to classify the assortment by detailed customer needs.\n            CBX: CNT_CODELIST.CODE (code list \""LIDL_CATEGORY_NEEDS\"")',
	MDM_CUST_NEED_TYPE_CD COMMENT 'Code to classify the assortment by general customer needs.\n            CBX: CNT_CODELIST.CODE (code list \""LIDL_FOCUS_CATEGORY\"")',
	MIN_CASE_DD,
	MIN_CASE_EURO,
	MIN_CASE_LAYER,
	MIN_CASE_ORDERUNIT,
	MIN_RECEIVE_TEMP,
	MINUS_FG,
	NET_CASE_WEIGHT,
	NET_PIECE_WEIGHT,
	ORDER_AREA_CD,
	PACKAGE_QTY,
	PACKAGETYPE_DESC,
	PACKING,
	PCT_CONSUMPTION_TAX,
	PCT_DISCOUNT,
	PERIOD_ID_SHELFLIFE_CUST,
	PERIOD_ID_SHELFLIFE_STORE,
	PERIOD_ID_SHELFLIFE_WH,
	PIECE_DEPTH,
	PIECE_HEIGHT,
	PIECE_VOLUME,
	PIECE_WEIGHT,
	PIECE_WIDTH,
	PIECE_NET_WEIGHT,
	POSTER_FG,
	PRICE_SIGN_FG,
	PRICE_STRIP_FG,
	QTY_CONSUMPTION_TAX_ADD,
	RES_SELLTIME,
	REUSABLE_FG,
	SCALE_FG,
	SEASON_FG,
	SMALLEST_ORDERUNIT,
	SMALLEST_UNIT,
	STATUS_ID_HQ,
	STOCK_CAPACITY,
	SUBITEMGROUP_ID,
	TAX_REFUND_FG,
	TAXATION,
	TYPE_CD,
	TYPE_RECEIVE_TEMP_FG,
	UNITSIZE,
	VAL_CONSUMPTION_TAX,
	VAL_DEPOSIT,
	VAT_ID,
	WALLOW_NR,
	WEIGHT,
	WEIGHT_FG,
	WG_FG,
	WRITE_OFF,
	BUYER_NAME_INT,
	CASE_SIZE_DEC,
	DUR_SHELFLIFE_TIMEUNITS_CUST,
	DUR_SHELFLIFE_TIMEUNITS_STORE,
	DUR_SHELFLIFE_TIMEUNITS_WH,
	FACTOR_PERIOD_CUST,
	FACTOR_PERIOD_STORE,
	FACTOR_PERIOD_WH,
	FACTOR_SHELFLIFE_CUST,
	FACTOR_SHELFLIFE_STORE,
	FACTOR_SHELFLIFE_WH,
	QTY_MIN_PIECE_ORDERING,
	ITEM_DESC_AT COMMENT 'Artikel_1 Landesspezifische Bezeichnung AT',
	ITEM_DESC_BE COMMENT 'Artikel_1 Landesspezifische Bezeichnung BE',
	ITEM_DESC_BE_FR COMMENT 'Artikel_1 Landesspezifische Bezeichnung BE_FR',
	ITEM_DESC_BG COMMENT 'Artikel_1 Landesspezifische Bezeichnung BG',
	ITEM_DESC_CH COMMENT 'Artikel_1 Landesspezifische Bezeichnung CH',
	ITEM_DESC_CY COMMENT 'Artikel_1 Landesspezifische Bezeichnung CY',
	ITEM_DESC_CZ COMMENT 'Artikel_1 Landesspezifische Bezeichnung CZ',
	ITEM_DESC COMMENT 'Artikel_1 Landesspezifische Bezeichnung',
	ITEM_DESC_DK COMMENT 'Artikel_1 Landesspezifische Bezeichnung DK',
	ITEM_DESC_EE COMMENT 'Artikel_1 Landesspezifische Bezeichnung EE',
	ITEM_DESC_ES COMMENT 'Artikel_1 Landesspezifische Bezeichnung ES',
	ITEM_DESC_FI COMMENT 'Artikel_1 Landesspezifische Bezeichnung FI',
	ITEM_DESC_FR COMMENT 'Artikel_1 Landesspezifische Bezeichnung FR',
	ITEM_DESC_GB COMMENT 'Artikel_1 Landesspezifische Bezeichnung GB',
	ITEM_DESC_GR COMMENT 'Artikel_1 Landesspezifische Bezeichnung GR',
	ITEM_DESC_HR COMMENT 'Artikel_1 Landesspezifische Bezeichnung HR',
	ITEM_DESC_HU COMMENT 'Artikel_1 Landesspezifische Bezeichnung HU',
	ITEM_DESC_IE COMMENT 'Artikel_1 Landesspezifische Bezeichnung IE',
	ITEM_DESC_IT COMMENT 'Artikel_1 Landesspezifische Bezeichnung IT',
	ITEM_DESC_LT COMMENT 'Artikel_1 Landesspezifische Bezeichnung LT',
	ITEM_DESC_LV COMMENT 'Artikel_1 Landesspezifische Bezeichnung LV',
	ITEM_DESC_NI COMMENT 'Artikel_1 Landesspezifische Bezeichnung NI',
	ITEM_DESC_NL COMMENT 'Artikel_1 Landesspezifische Bezeichnung NL',
	ITEM_DESC_DE COMMENT 'Artikel_1 Landesspezifische Bezeichnung DE',
	ITEM_DESC_PL COMMENT 'Artikel_1 Landesspezifische Bezeichnung PL',
	ITEM_DESC_PT COMMENT 'Artikel_1 Landesspezifische Bezeichnung PT',
	ITEM_DESC_RO COMMENT 'Artikel_1 Landesspezifische Bezeichnung RO',
	ITEM_DESC_SE COMMENT 'Artikel_1 Landesspezifische Bezeichnung SE',
	ITEM_DESC_SI COMMENT 'Artikel_1 Landesspezifische Bezeichnung SI',
	ITEM_DESC_SK COMMENT 'Artikel_1 Landesspezifische Bezeichnung SK',
	ITEM_DESC_CS COMMENT 'Artikel_1 Landesspezifische Bezeichnung CS',
	ITEM_DESC_MT COMMENT 'Artikel_1 Landesspezifische Bezeichnung MT',
	ITEM_DESC_US COMMENT 'Artikel_1 Landesspezifische Bezeichnung US',
	ITEM_DESC_RS COMMENT 'Artikel_1 Landesspezifische Bezeichnung RS_1'
) as
SELECT
   brand_1
  ,buying_list_orderset_nr
  ,case_size
  ,client_id
  ,country_cd
  ,dat_valid_from
  ,item_id
  ,orig_item_nr
  ,orig_item_nr_int
  ,add_docs_fg
  ,additions
  ,age_fg
  ,beverage_tax
  ,buyer_id
  ,buyer_name
  ,buying_list_type_id
  ,buying_list_type_desc
  ,brand_type_id
  ,listing_type_id
  ,case_dd
  ,case_depth
  ,case_euro
  ,case_height
  ,case_layer
  ,case_plu_fg
  ,case_volume
  ,case_weight
  ,case_width
  ,commodity_cd
  ,consumption_tax_main_id
  ,consumption_tax_sub_id
  ,cont_deposit_item_nr
  ,contract_country_cd
  ,dangerous_goods_fg
  ,dat_adv
  ,dat_delisting
  ,dat_listing
  ,dat_min_shelflifetest_fg
  ,delisting_fg
  ,delivery_temp
  ,direct_delete_mde_fg
  ,discount_fg
  ,dualsystem_fg
  ,dur_shelflife_day_cust
  ,dur_shelflife_day_store
  ,dur_shelflife_day_wh
  ,food_fg
  ,forwarding_item_nr
  ,int_subitemgroup_id
  ,item_actiongroup_id
  ,item_familygroup_id
  ,item_parts
  ,item_parts_cd
  ,item_plu_nr
  ,item_short_desc_1
  ,item_short_desc_2
  ,item_short_desc_3
  ,item_sub_actiongroup_id
  ,item_text_1
  ,item_text_2
  ,item_text_3
  ,item_version
  ,lidl_buying_country_cd
  ,listing_fg
  ,logistic_unit_cd
  ,max_receive_temp
  ,mdessp_fg
  ,mdm_cust_need_subtype_cd
  ,mdm_cust_need_type_cd
  ,min_case_dd
  ,min_case_euro
  ,min_case_layer
  ,min_case_orderunit
  ,min_receive_temp
  ,minus_fg
  ,net_case_weight
  ,net_piece_weight
  ,order_area_cd
  ,package_qty
  ,packagetype_desc
  ,packing
  ,pct_consumption_tax
  ,pct_discount
  ,period_id_shelflife_cust
  ,period_id_shelflife_store
  ,period_id_shelflife_wh
  ,piece_depth
  ,piece_height
  ,piece_volume
  ,piece_weight
  ,piece_width
  ,piece_net_weight
  ,poster_fg
  ,price_sign_fg
  ,price_strip_fg
  ,qty_consumption_tax_add
  ,res_selltime
  ,reusable_fg
  ,scale_fg
  ,season_fg
  ,smallest_orderunit
  ,smallest_unit
  ,status_id_hq
  ,stock_capacity
  ,subitemgroup_id
  ,tax_refund_fg
  ,taxation
  ,type_cd
  ,type_receive_temp_fg
  ,unitsize
  ,val_consumption_tax
  ,val_deposit
  ,vat_id
  ,wallow_nr
  ,weight
  ,weight_fg
  ,wg_fg
  ,write_off
  ,buyer_name_int
  ,case_size_dec
  ,dur_shelflife_timeunits_cust
  ,dur_shelflife_timeunits_store
  ,dur_shelflife_timeunits_wh
  ,factor_period_cust
  ,factor_period_store
  ,factor_period_wh
  ,factor_shelflife_cust
  ,factor_shelflife_store
  ,factor_shelflife_wh
  ,qty_min_piece_ordering
  ,ITEM_DESC_AT
  ,ITEM_DESC_BE
  ,ITEM_DESC_BE                AS ITEM_DESC_BE_FR
  ,ITEM_DESC_BG
  ,ITEM_DESC_CH
  ,ITEM_DESC_CY
  ,ITEM_DESC_CZ
  ,ITEM_DESC
  ,ITEM_DESC_DK
  ,ITEM_DESC_EE
  ,ITEM_DESC_ES
  ,ITEM_DESC_FI
  ,ITEM_DESC_FR
  ,ITEM_DESC_GB
  ,ITEM_DESC_GR
  ,ITEM_DESC_HR
  ,ITEM_DESC_HU
  ,ITEM_DESC_IE
  ,ITEM_DESC_IT
  ,ITEM_DESC_LT
  ,ITEM_DESC_LV
  ,ITEM_DESC_NI
  ,ITEM_DESC_NL
  ,ITEM_DESC_DE
  ,ITEM_DESC_PL
  ,ITEM_DESC_PT
  ,ITEM_DESC_RO
  ,ITEM_DESC_SE
  ,ITEM_DESC_SI
  ,ITEM_DESC_SK
  ,ITEM_DESC_CS
  ,ITEM_DESC_MT
  ,ITEM_DESC_US
  ,ITEM_DESC_RS
FROM p_lew_mart_lead.t_itm_item_1;
