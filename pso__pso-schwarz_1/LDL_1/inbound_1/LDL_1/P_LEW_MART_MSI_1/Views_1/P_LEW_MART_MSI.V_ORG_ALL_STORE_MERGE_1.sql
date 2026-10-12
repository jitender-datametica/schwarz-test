create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_MSI.V_ORG_ALL_STORE_MERGE_1(
	ASPECT_ID,
	CLIENT_ID,
	MOVE_TO_STORE_ID,
	MOVE_STORE_DESC,
	WH_ID,
	WH_ID_EXP,
	SALES_MANAGER_ID,
	SALES_MANAGER_WORKFORCE_NR,
	DAT_CLOSING_OVIS,
	DAT_OPENING_OVIS,
	MIS_STORE_ACTIVE_FG,
	DAT_OPENING,
	DAT_CLOSING,
	ORIG_STORE_NR,
	DAT_CALC_START_PY,
	DAT_CALC_END_PY,
	OBJECTSTATUS_ID,
	DAT_CALC_START_PPY,
	MOVE_FG,
	STREET,
	ZIPCODE,
	CITY,
	PHONE,
	LONGITUDE,
	LATITUDE,
	DAT_MODERNIZATION_FROM,
	DAT_MODERNIZATION_TO,
	ACCOUNT_MANAGER_ID,
	ACCOUNT_MANAGER_WORKFORCE_NR,
	SALES_MANAGER_NAME,
	ACCOUNT_MANAGER_NAME,
	COUNTRY_CD,
	GL_REGION_ID,
	COSTCENTER_CD,
	COMPANY,
	ORDER_BUYING_LIST_CD,
	VAT_REGION_NR,
	REGION_CD,
	STOCK_PLAIN,
	SPONSION,
	GLOBAL_LOCATION_NR,
	WH_DESC,
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
SELECT   org.aspect_id
       , org.client_id
       , org.move_to_store_id
       , org.move_store_desc
       , org.wh_id
       , org.wh_id_exp
       , org.sales_manager_id
       , sm.emp_workforce_nr AS sales_manager_workforce_nr
       , org.dat_closing_ovis
       , org.dat_opening_ovis
       , org.mis_store_active_fg
       , org.dat_opening
       , org.dat_closing
       , org.orig_store_nr
       , org.dat_calc_start_py
       , org.dat_calc_end_py
       , org.objectstatus_id
       , org.dat_calc_start_ppy
       , org.move_fg
       , org.street
       , org.zipcode
       , org.city
       , org.phone
       , org.longitude
       , org.latitude
       , org.dat_modernization_from
       , org.dat_modernization_to
       , org.account_manager_id
       , am.emp_workforce_nr AS account_manager_workforce_nr
       , org.sales_manager_name
       , org.account_manager_name
       , org.country_cd
       , org.gl_region_id
       , org.costcenter_cd
       , org.company
       , org.order_buying_list_cd
       , org.vat_region_nr
       , org.region_cd
       , org.stock_plain
       , org.sponsion
       , org.global_location_nr
       , org.wh_desc
       , org.distribute_wh_fg
       , org.int_fg
       , org.hq_fg
       , org.prop_wh_fg
       , org.sales_wh_fg
       , org.supp_wh_fg
       , org.wawi_data_fg
       , org.ovis_data_fg
       , org.parent_wh_id
       , org.buying_region
       , org.gl_region_desc
       , org.gl_last_name
       , org.gl_first_name
       , org.int_id
       , org.country_iso_cd
       , org.country_group_id
       , org.lisy_sort
       , org.dashboard_relevant_fg
       , org.country_desc_AT
       , org.country_desc_BE
       , org.country_desc_FR AS country_desc_BE_FR
       , org.country_desc_BG
       , org.country_desc_CH
       , org.country_desc_CY
       , org.country_desc_CZ
       , org.country_desc
       , org.country_desc_DK
       , org.country_desc_EE
       , org.country_desc_ES
       , org.country_desc_FI
       , org.country_desc_FR
       , org.country_desc_GB
       , org.country_desc_GR
       , org.country_desc_HR
       , org.country_desc_HU
       , org.country_desc_IE
       , org.country_desc_IT
       , org.country_desc_LT
       , org.country_desc_LV
       , org.country_desc_NI
       , org.country_desc_NL
       , org.country_desc_DE
       , org.country_desc_PL
       , org.country_desc_PT
       , org.country_desc_RO
       , org.country_desc_SE
       , org.country_desc_SI
       , org.country_desc_SK
       , org.country_desc_CS
       , org.country_desc_MT
       , org.country_desc_US
       , org.country_desc_RS
       
       , org.country_opening_date
  FROM P_LEW_MART_MSI.t_org_all_store_merge_1 AS org
  LEFT JOIN p_lew_core.t_employee_1 AS sm_1
    ON  org.client_id        = sm.client_id
    AND org.sales_manager_id = sm.emp_sid
  LEFT JOIN p_lew_core.t_employee_1 AS am
    ON  org.client_id          = am.client_id
    AND org.account_manager_id = am.emp_sid
;
