create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_ORG_WH_MERGE_1(
	ASPECT_ID,
	CLIENT_ID,
	WH_ID,
	COUNTRY_CD,
	GL_REGION_ID,
	DAT_OPENING,
	COSTCENTER_CD,
	COMPANY,
	ORDER_BUYING_LIST_CD,
	VAT_REGION_NR,
	REGION_CD,
	STOCK_PLAIN,
	SPONSION,
	GLOBAL_LOCATION_NR,
	WH_DESC,
	WH_DESC_SHORT COMMENT 'WH name abbreviation without whitespaces, ampersands and minus signs',
	DISTRIBUTE_WH_FG,
	INT_FG,
	HQ_FG,
	PROP_WH_FG,
	SALES_WH_FG,
	SUPP_WH_FG,
	WAWI_DATA_FG,
	OVIS_DATA_FG,
	PARENT_WH_ID,
	BUYING_REGION,
	GL_REGION_DESC,
	GL_LAST_NAME,
	GL_FIRST_NAME,
	STREET,
	CITY,
	PHONE_NUMBER,
	INT_ID,
	COUNTRY_ISO_CD,
	COUNTRY_GROUP_ID,
	LISY_SORT,
	DASHBOARD_RELEVANT_FG,
	COUNTRY_DESC_AT,
	COUNTRY_DESC_BE,
	COUNTRY_DESC_BE_FR,
	COUNTRY_DESC_BG,
	COUNTRY_DESC_CH,
	COUNTRY_DESC_CY,
	COUNTRY_DESC_CZ,
	COUNTRY_DESC,
	COUNTRY_DESC_DK,
	COUNTRY_DESC_EE,
	COUNTRY_DESC_ES,
	COUNTRY_DESC_FI,
	COUNTRY_DESC_FR,
	COUNTRY_DESC_GB,
	COUNTRY_DESC_GR,
	COUNTRY_DESC_HR,
	COUNTRY_DESC_HU,
	COUNTRY_DESC_IE,
	COUNTRY_DESC_IT,
	COUNTRY_DESC_LT,
	COUNTRY_DESC_LV,
	COUNTRY_DESC_NI,
	COUNTRY_DESC_NL,
	COUNTRY_DESC_DE,
	COUNTRY_DESC_PL,
	COUNTRY_DESC_PT,
	COUNTRY_DESC_RO,
	COUNTRY_DESC_SE,
	COUNTRY_DESC_SI,
	COUNTRY_DESC_SK,
	COUNTRY_DESC_CS,
	COUNTRY_DESC_MT,
	COUNTRY_DESC_US,
	COUNTRY_DESC_RS,
	COUNTRY_OPENING_DATE
) as
SELECT  
	aspect_id
	, client_id
	, wh_id
	, country_cd
	, gl_region_id
	, dat_opening
	, costcenter_cd
	, company
	, order_buying_list_cd
	, vat_region_nr
	, region_cd
	, stock_plain
	, sponsion
	, global_location_nr
	, wh_desc
	, wh_desc_short
	, distribute_wh_fg
	, int_fg
	, hq_fg
	, prop_wh_fg
	, sales_wh_fg
	, supp_wh_fg
	, wawi_data_fg
	, ovis_data_fg
	, parent_wh_id
	, buying_region
	, gl_region_desc
	, gl_last_name
	, gl_first_name
	, street
	, city
	, phone_number
	, int_id
	, country_iso_cd
	, country_group_id
	, lisy_sort
	, dashboard_relevant_fg
	, country_desc_AT
	, country_desc_BE
	, country_desc_BE_FR
	, country_desc_BG
	, country_desc_CH
	, country_desc_CY
	, country_desc_CZ
	, country_desc
	, country_desc_DK
	, country_desc_EE
	, country_desc_ES
	, country_desc_FI
	, country_desc_FR
	, country_desc_GB
	, country_desc_GR
	, country_desc_HR
	, country_desc_HU
	, country_desc_IE
	, country_desc_IT
	, country_desc_LT
	, country_desc_LV
	, country_desc_NI
	, country_desc_NL
	, country_desc_DE
	, country_desc_PL
	, country_desc_PT
	, country_desc_RO
	, country_desc_SE
	, country_desc_SI
	, country_desc_SK
	, country_desc_CS
	, country_desc_MT
	, country_desc_US
	, country_desc_RS
	, country_opening_date
FROM p_lew_mart_msi.v_org_wh_merge_1
;
