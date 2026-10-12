create or replace view LDL_DATA_PRODUCTION.CORE_DIM.V_DIM_STORE_NEW_1(
	STORE_SID COMMENT 'The unique identifier (surrogate key) for a store.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	CURR_STORE_NR COMMENT 'The number by which the store is currently known to business. The store number is identical to the real estate number of the object which currently houses the store. In case the building changes, the store_sid remains unchanged, but the store number gets updated.',
	INIT_STORE_NR COMMENT 'The initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. This number does not change, in case the building changes.',
	STORE_NAME COMMENT 'The name of the store.',
	INT_ORG_STATUS_CD COMMENT 'The code for the retail status_1 of a store. The status_1 codes for <open> and <closed> are strictly connected with the store open date and the store close date, as they are derived from these attributes.',
	INT_ORG_STATUS_DESCR COMMENT 'A textual description for the retail status_1 (open / closed) of a store in group language, i.e. in German.',
	OPEN_DT COMMENT 'The date when the store has started its regular operation. (This date may be different from the planned opening date.)',
	PLANNED_OPEN_DT COMMENT 'The expected opening date of the store.',
	CLOSE_DT COMMENT 'The closing date of the store as set by WAWI. (NULL if the store is open.)',
	ISO_COUNTRY_CD COMMENT 'The code according to ISO 3166 identifying the country_1, in which the store is located,',
	COUNTRY_NAME COMMENT 'The name of the country_1, in which the store is located,',
	CITY_NAME COMMENT 'The name of the city where the store is located.',
	DISTRICT_NAME COMMENT 'The name of the district, in which the store is located,',
	ZIP COMMENT 'The postal code of the store address.',
	STREET_NAME COMMENT 'The name of the street where the store is located.',
	HOUSE_NR COMMENT 'The number of the building within the street where the store is located.',
	LON COMMENT 'The geographical longitude of the store address.',
	LAT COMMENT 'The geographical latitude of the store address.',
	PO_BOX_NR COMMENT 'The post box number of the store. (NULL if the store does not have post box.)',
	PHONE_NR COMMENT 'The telephone number of the store.',
	FAX_NR COMMENT 'The telefax number of the store.',
	EMAIL_ADDR_TXT COMMENT 'An email address_1 for that store.',
	SALES_MGR_DISTRICT_SID COMMENT 'The unique identifier (surrogate key) for the organizational unit_1 for which the related sales_1 manager is responsible.',
	SALES_MGR_DISTRICT_NR COMMENT 'The number which identifies the organizational unit_1 for which the related sales_1 manager is responsible.',
	SALES_MGR_DISTRICT_NAME COMMENT 'The name of the related sales_1 manager district.',
	SALES_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1, who is currently filling the position of the related sales_1 manager.',
	SALES_MGR_EMP_NR COMMENT 'The employee_1 number of the person who is currently filling the position of the related sales_1 manager.',
	SALES_MGR_NAME COMMENT 'The name of the person who is currently filling the position of the related sales_1 manager.',
	ACCT_MGR_DISTRICT_SID COMMENT 'The unique identifier (surrogate key) for the organizational unit_1 for which the related account_1 manager is responsible.',
	ACCT_MGR_DISTRICT_NR COMMENT 'The number which identifies the organizational unit_1 for which the related account_1 manager is responsible.',
	ACCT_MGR_DISTRICT_NAME COMMENT 'The name of the related account_1 manager district.',
	ACCT_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1, who is currently filling the positon of the related account_1 manager.',
	ACCT_MGR_EMP_NR COMMENT 'The employee_1 number of the person who is currently filling the position of the related account_1 manager.',
	ACCT_MGR_NAME COMMENT 'The name of the person who is currently filling the position of the related account_1 manager.',
	SALES_COMPANY_SID COMMENT 'The unique identifier (surrogate key) for the sales_1 company (VGES) to which this store is related.',
	SALES_COMPANY_NR COMMENT 'The number which identifies the sales_1 company (VGES) to which this store is related.',
	SALES_COMPANY_NAME COMMENT 'The name of the sales_1 company to which this store is related..',
	SALES_COMPANY_DIRECTOR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1, who is the director of the related sales_1 company.',
	SALES_COMPANY_DIRECTOR_EMP_NR COMMENT 'The employee_1 number of the director of the related sales_1 company.',
	SALES_COMPANY_DIRECTOR_NAME COMMENT 'The name of the manager of the related sales_1 company.',
	DELIV_COMPANY_SID COMMENT 'Surrogate key for the delivery company which is responsible for this store.',
	DELIV_COMPANY_SUB_SID COMMENT 'Dummy_1 for PoC',
	DELIV_COMPANY_NR COMMENT 'The number which identifies the delivery company which is responsible for this store.',
	DELIV_COMPANY_NAME COMMENT 'The name of the delivery company which is responsible for this store..',
	DELIV_COMPANY_DIRECTOR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1, who is the director of the related delivery company.',
	DELIV_COMPANY_DIRECTOR_EMP_NR COMMENT 'The employee_1 number of the director of the related delivery company.',
	DELIV_COMPANY_DIRECTOR_NAME COMMENT 'The name of the manager of the related delivery company.',
	EXPANSION_COMPANY_SID COMMENT 'The unique identifier (surrogate key) for the expansion company which is responsible for this store.',
	EXPANSION_COMPANY_NR COMMENT 'The number which identifies the expansion company which is responsible for this store.',
	EXPANSION_COMPANY_NAME COMMENT 'The name of the expansion company which is responsible for this store.',
	BAL_SHEET_COMPANY_SID COMMENT 'The unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..',
	BAL_SHEET_COMPANY_NR COMMENT 'The number which identifies the balance sheet company, which is responsible for this store..',
	BAL_SHEET_COMPANY_NAME COMMENT 'The name of the balance sheet company, which is responsible for this store..',
	OWNER_COMPANY_SID COMMENT 'The unique identifier (surrogate key) for the owner company, which is responsible for this store..',
	OWNER_COMPANY_NR COMMENT 'The number which identifies the owner company, which is responsible for this store..',
	OWNER_COMPANY_NAME COMMENT 'The name of the owner company, which is responsible for this store..',
	ORG_REGION_SID COMMENT 'The unique identifier (surrogate key) for the related organizational region_1',
	ORG_REGION_NR COMMENT 'The number which identifies the related organizational region.',
	ORG_REGION_NAME COMMENT 'The name of the related organizational region.',
	ORG_REGION_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related organizational region.',
	ORG_REGION_MGR_EMP_NR COMMENT 'The employee_1 number of the person who is currently filling the role of the manager of the related organizational region.',
	ORG_REGION_MGR_NAME COMMENT 'The name of the manager of the related organizational region.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
	COUNTRY_ORG_CD COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
	COUNTRY_ORG_NR COMMENT 'The number which identifies the related country_1 organization.',
	COUNTRY_ORG_NAME COMMENT 'The name for the related country_1 organization. (name in group language, i.e. in German). (The country_1 organization is not necessarily identical with a political country_1,)',
	COUNTRY_ORG_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1 who is responsible for the related country_1 organization.',
	COUNTRY_ORG_MGR_EMP_NR COMMENT 'The employee_1 number of the manager who is responsible for the related country_1 organization.',
	COUNTRY_ORG_MGR_NAME COMMENT 'The name of the manager who is responsible for the related country_1 organization.',
	COUNTRY_GRP_ORG_SID COMMENT 'The unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NR COMMENT 'The number which identifies the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NAME COMMENT 'The name for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_SID COMMENT 'The unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_NR COMMENT 'The employee_1 number of the manager who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_NAME COMMENT 'The name of the manager who is responsible for the related group of countries.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A store, seen as an internal organization unit_1 of the Schwarz Group. A store is located at a physical address. Its purpose is to offer goods to customers. Online-stores are not covered by this definition of a store. Note that the building that houses the store, is a resource item.'
 as SELECT
main.store_sid AS store_sid
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_store_nr AS curr_store_nr
,main.init_store_nr AS init_store_nr
,main.store_name AS store_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
--,main.real_estate_sid AS real_estate_sid
,main.open_dt AS open_dt
,main.planned_open_dt AS planned_open_dt
,main.close_dt AS close_dt
,main.iso_country_cd AS iso_country_cd
,main.country_name AS country_name
,main.city_name AS city_name
,main.district_name AS district_name
,main.zip AS zip
,main.street_name AS street_name
,main.house_nr AS house_nr
,main.lon AS lon
,main.lat AS lat
,main.po_box_nr AS po_box_nr
,main.phone_nr AS phone_nr
,main.fax_nr AS fax_nr
,main.email_addr_txt AS email_addr_txt
,main.sales_mgr_district_sid AS sales_mgr_district_sid
,main.sales_mgr_district_nr AS sales_mgr_district_nr
,main.sales_mgr_district_name AS sales_mgr_district_name
,main.sales_mgr_emp_sid AS sales_mgr_emp_sid
,main.sales_mgr_emp_nr AS sales_mgr_emp_nr
,main.sales_mgr_name AS sales_mgr_name
,main.acct_mgr_district_sid AS acct_mgr_district_sid
,main.acct_mgr_district_nr AS acct_mgr_district_nr
,main.acct_mgr_district_name AS acct_mgr_district_name
,main.acct_mgr_emp_sid AS acct_mgr_emp_sid
,main.acct_mgr_emp_nr AS acct_mgr_emp_nr
,main.acct_mgr_name AS acct_mgr_name
,main.sales_company_sid AS sales_company_sid
,main.sales_company_nr AS sales_company_nr
,main.sales_company_name AS sales_company_name
,main.sales_company_director_emp_sid AS sales_company_director_emp_sid
,main.sales_company_director_emp_nr AS sales_company_director_emp_nr
,main.sales_company_director_name AS sales_company_director_name
--,decode(main.deliv_company_sid,55,58,main.deliv_company_sid) AS deliv_company_sid
,main.deliv_company_sid AS deliv_company_sid
,main.deliv_company_sid *10 + mod(store_sid,10) as  deliv_company_sub_sid
,main.deliv_company_nr AS deliv_company_nr
,main.deliv_company_name AS deliv_company_name
,main.deliv_company_director_emp_sid AS deliv_company_director_emp_sid
,main.deliv_company_director_emp_nr AS deliv_company_director_emp_nr
,main.deliv_company_director_name AS deliv_company_director_name
,main.expansion_company_sid AS expansion_company_sid
,main.expansion_company_nr AS expansion_company_nr
,main.expansion_company_name AS expansion_company_name
,main.bal_sheet_company_sid AS bal_sheet_company_sid
,main.bal_sheet_company_nr AS bal_sheet_company_nr
,main.bal_sheet_company_name AS bal_sheet_company_name
,main.owner_company_sid AS owner_company_sid
,main.owner_company_nr AS owner_company_nr
,main.owner_company_name AS owner_company_name
,main.sales_region_sid AS org_region_sid
,main.sales_region_nr AS org_region_nr
,main.sales_region_name AS org_region_name
,main.sales_region_mgr_emp_sid AS org_region_mgr_emp_sid
,main.sales_region_mgr_emp_nr AS org_region_mgr_emp_nr
,main.sales_region_mgr_name AS org_region_mgr_name
,main.country_org_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.country_org_nr AS country_org_nr
,main.country_org_name AS country_org_name
,main.country_org_mgr_emp_sid AS country_org_mgr_emp_sid
,main.country_org_mgr_emp_nr AS country_org_mgr_emp_nr
,main.country_org_mgr_name AS country_org_mgr_name
,main.country_grp_org_sid AS country_grp_org_sid
,main.country_grp_org_nr AS country_grp_org_nr
,main.country_grp_org_name AS country_grp_org_name
,main.country_grp_org_mgr_emp_sid AS country_grp_org_mgr_emp_sid
,main.country_grp_org_mgr_emp_nr AS country_grp_org_mgr_emp_nr
,main.country_grp_org_mgr_name AS country_grp_org_mgr_name
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_STORE_PERFORMANCE_TESTING main WHERE main.dwh_valid_fg = TRUE;