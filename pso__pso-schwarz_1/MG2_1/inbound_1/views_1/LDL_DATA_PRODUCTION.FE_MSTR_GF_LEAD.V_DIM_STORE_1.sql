create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_STORE_1(
	STORE_SID COMMENT 'the unique identifier (surrogate key) for a store.',
	INT_ORG_TYPE_CD COMMENT 'the internal organanisation type like store, company...',
	DWH_VALID_FROM_TMSP COMMENT 'the point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'the point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	CURR_STORE_NR COMMENT 'the number by which the store is currently known to business. the store number is identical to the real estate number of the object which currently houses the store. in case the building changes, the store_sid remains unchanged, but the store number gets updated.',
	INIT_STORE_NR COMMENT 'the initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. this number does not change, in case the building changes.',
	STORE_NAME COMMENT 'the name of the store.',
	INT_ORG_STATUS_CD COMMENT 'the code for the retail status_1 of a store. the status_1 codes for <open> and <closed> are strictly connected with the store open date and the store close date, AS they are derived from these attributes.',
	INT_ORG_STATUS_DESCR COMMENT 'a textual description for the retail status_1 (open / closed) of a store in group language, i.e. in german.',
	STORE_REAL_ESTATE_TYPE_CD COMMENT 'The code identifying the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. ',
	STORE_REAL_ESTATE_TYPE_DESCR COMMENT 'A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in group language, i.e. in German)',
	OPEN_DT COMMENT 'the date when the store has started its regular operation. (this date may be different from the planned opening date.)',
	PLANNED_OPEN_DT COMMENT 'the expected opening date of the store.',
	CLOSE_DT COMMENT 'the closing date of the store AS set by wawi. (null if the store is open.)',
	COUNTRY_CD COMMENT 'the code according to iso 3166 identifying the country_1, in which the store is located,',
	COUNTRY_NAME COMMENT 'the name of the country_1, in which the store is located,',
	REPORTING_COUNTRY_CD COMMENT 'the code according to iso 3166 identifying the country_1, in which the store is located,',
	REPORTING_COUNTRY_NAME COMMENT 'the name of the country_1, in which the store is located,',
	CITY_NAME COMMENT 'the name of the city where the store is located.',
	DISTRICT_NAME COMMENT 'the name of the district, in which the store is located,',
	ZIP COMMENT 'the postal code of the store address.',
	STREET_NAME COMMENT 'the name of the street where the store is located.',
	HOUSE_NR COMMENT 'the number of the building within the street where the store is located.',
	LON COMMENT 'the geographical longitude of the store address.',
	LAT COMMENT 'the geographical latitude of the store address.',
	PO_BOX_NR COMMENT 'the post box number of the store. (null if the store does not have post box.)',
	PHONE_NR COMMENT 'the telephone number of the store.',
	FAX_NR COMMENT 'the telefax number of the store.',
	EMAIL_ADDR_TXT COMMENT 'an email address_1 for that store.',
	SALES_MGR_DISTRICT_SID COMMENT 'the unique identifier (surrogate key) for the organizational unit_1 for which the related sales_1 manager is responsible.',
	SALES_MGR_DISTRICT_NR COMMENT 'the number which identifies the organizational unit_1 for which the related sales_1 manager is responsible.',
	SALES_MGR_DISTRICT_NAME COMMENT 'the name of the related sales_1 manager district.',
	SALES_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1, who is currently filling the position of the related sales_1 manager.',
	SALES_MGR_EMP_NR COMMENT 'the employee_1 number of the person who is currently filling the position of the related sales_1 manager.',
	SALES_MGR_NAME COMMENT 'the name of the person who is currently filling the position of the related sales_1 manager.',
	ACCT_MGR_DISTRICT_SID COMMENT 'the unique identifier (surrogate key) for the organizational unit_1 for which the related account_1 manager is responsible.',
	ACCT_MGR_DISTRICT_NR COMMENT 'the number which identifies the organizational unit_1 for which the related account_1 manager is responsible.',
	ACCT_MGR_DISTRICT_NAME COMMENT 'the name of the related account_1 manager district.',
	ACCT_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1, who is currently filling the positon of the related account_1 manager.',
	ACCT_MGR_EMP_NR COMMENT 'the employee_1 number of the person who is currently filling the position of the related account_1 manager.',
	ACCT_MGR_NAME COMMENT 'the name of the person who is currently filling the position of the related account_1 manager.',
	SALES_COMPANY_SID COMMENT 'the unique identifier (surrogate key) for the sales_1 company (vges) to which this store is related.',
	SALES_COMPANY_NR COMMENT 'the number which identifies the sales_1 company (vges) to which this store is related.',
	SALES_COMPANY_NAME COMMENT 'the name of the sales_1 company to which this store is related..',
	SALES_COMPANY_DIRECTOR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1, who is the director of the related sales_1 company.',
	SALES_COMPANY_DIRECTOR_EMP_NR COMMENT 'the employee_1 number of the director of the related sales_1 company.',
	SALES_COMPANY_DIRECTOR_NAME COMMENT 'the name of the manager of the related sales_1 company.',
	DELIV_COMPANY_SID COMMENT 'surrogate key for the delivery company which is responsible for this store.',
	DELIV_COMPANY_NR COMMENT 'the number which identifies the delivery company which is responsible for this store.',
	DELIV_COMPANY_NAME COMMENT 'the name of the delivery company which is responsible for this store..',
	DELIV_COMPANY_DIRECTOR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1, who is the director of the related delivery company.',
	DELIV_COMPANY_DIRECTOR_EMP_NR COMMENT 'the employee_1 number of the director of the related delivery company.',
	DELIV_COMPANY_DIRECTOR_NAME COMMENT 'the name of the manager of the related delivery company.',
	EXPANSION_COMPANY_SID COMMENT 'the unique identifier (surrogate key) for the expansion company which is responsible for this store.',
	EXPANSION_COMPANY_NR COMMENT 'the number which identifies the expansion company which is responsible for this store.',
	EXPANSION_COMPANY_NAME COMMENT 'the name of the expansion company which is responsible for this store.',
	BAL_SHEET_COMPANY_SID COMMENT 'the unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..',
	BAL_SHEET_COMPANY_NR COMMENT 'the number which identifies the balance sheet company, which is responsible for this store..',
	BAL_SHEET_COMPANY_NAME COMMENT 'the name of the balance sheet company, which is responsible for this store..',
	OWNER_COMPANY_SID COMMENT 'the unique identifier (surrogate key) for the owner company, which is responsible for this store..',
	OWNER_COMPANY_NR COMMENT 'the number which identifies the owner company, which is responsible for this store..',
	OWNER_COMPANY_NAME COMMENT 'the name of the owner company, which is responsible for this store..',
	COUNTRY_ORG_SID COMMENT 'the unique identifier (surrogate key) for the related country_1 organization.',
	COUNTRY_ORG_CD COMMENT 'the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)',
	COUNTRY_ORG_NR COMMENT 'the number which identifies the related country_1 organization.',
	COUNTRY_ORG_NAME COMMENT 'the name for the related country_1 organization. (name in group language, i.e. in german). (the country_1 organization is not necessarily identical with a political country_1,)',
	LEGAL_NAME COMMENT 'the name for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_ORG_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1 who is responsible for the related country_1 organization.',
	COUNTRY_ORG_MGR_EMP_NR COMMENT 'the employee_1 number of the manager who is responsible for the related country_1 organization.',
	COUNTRY_ORG_MGR_NAME COMMENT 'the name of the manager who is responsible for the related country_1 organization.',
	COUNTRY_GRP_ORG_SID COMMENT 'the unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NR COMMENT 'the number which identifies the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NAME COMMENT 'the name for the related organizational unit_1 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_NR COMMENT 'the employee_1 number of the manager who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_NAME COMMENT 'the name of the manager who is responsible for the related group of countries.',
	DWH_CREATED_TMSP COMMENT 'the point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'the point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.',
	DELIV_REGION_MGR_EMP_NR COMMENT 'the employee_1 number of the person who is currently filling the role of the manager of the related delivery region.',
	DELIV_REGION_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related delivery region.',
	DELIV_REGION_MGR_NAME COMMENT 'the name of the manager of the related delivery region.',
	DELIV_REGION_NAME COMMENT 'the name of the related delivery region.',
	DELIV_REGION_NR COMMENT 'the number which identifies the related delivery region.',
	DELIV_REGION_SID COMMENT 'the unique identifier (surrogate key) for the related delivery region_1',
	SALES_REGION_MGR_EMP_NR COMMENT 'the employee_1 number of the person who is currently filling the role of the manager of the related sales_1 region.',
	SALES_REGION_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related sales_1 region.',
	SALES_REGION_MGR_NAME COMMENT 'the name of the manager of the related sales_1 region.',
	SALES_REGION_NAME COMMENT 'the name of the related sales_1 region.',
	SALES_REGION_NR COMMENT 'the number which identifies the related sales_1 region.',
	SALES_REGION_SID COMMENT 'the unique identifier (surrogate key) for the related sales_1 region_1'
) COMMENT='A store, seen AS an internal organization unit_1 of the Schwarz Group. A store is located at a physical address. Its purpose is to offer goods to customers. Online-stores are not covered by this definition of a store. Note that the building that houses the store, is a resource item.'
 as  SELECT 
main.int_org_sid AS store_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_1',
        main.int_org_type_cd) AS int_org_type_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS curr_store_nr
,main.init_int_org_nr AS init_store_nr
,main.int_org_name AS store_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
,CASE WHEN main.int_org_sid=main.country_org_sid THEN 'Country_1' WHEN main.int_org_type_cd='STORE' THEN main.store_real_estate_type_cd ELSE 'n/a' END AS store_real_estate_type_cd
,CASE WHEN main.int_org_sid=main.country_org_sid THEN 'Country_1' WHEN main.int_org_type_cd='STORE' THEN main.store_real_estate_type_descr ELSE 'n/a' END AS store_real_estate_type_descr 
,main.open_dt AS open_dt
,main.planned_open_dt AS planned_open_dt
,main.close_dt AS close_dt
,main.iso_country_cd AS iso_country_cd
,main.country_name AS country_name
,main.reporting_country_cd AS reporting_country_cd
,main.reporting_country_name AS reporting_country_name
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
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_district_sid,
        main.sales_company_sid,main.sales_company_sid,
        main.sales_region_sid,main.sales_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_mgr_district_sid) AS sales_mgr_district_sid
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_district_nr,
        main.sales_company_sid,main.sales_company_nr,
        main.sales_region_sid,main.sales_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.sales_mgr_district_nr) AS sales_mgr_district_nr
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_district_name,
        main.sales_company_sid,main.sales_company_name ,
        main.sales_region_sid,main.sales_region_name,
        main.country_org_sid,'Unbekannt',
        main.sales_mgr_district_name) AS sales_mgr_district_name
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_emp_sid,
        main.sales_company_sid,main.sales_mgr_emp_sid ,
        main.sales_region_sid,main.sales_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_mgr_emp_sid) AS sales_mgr_emp_sid
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_emp_nr,
        main.sales_company_sid,main.sales_mgr_emp_nr,
        main.sales_region_sid,main.sales_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.sales_mgr_emp_nr) AS sales_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.acct_mgr_district_sid,main.acct_mgr_name,
        main.sales_company_sid,main.sales_mgr_name,
        main.sales_region_sid,main.sales_region_mgr_name,
        main.country_org_sid,'Unbekannt',
        main.sales_mgr_name) AS sales_mgr_name
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_sid,
        main.sales_region_sid,main.sales_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.acct_mgr_district_sid) AS acct_mgr_district_sid
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_nr,
        main.sales_region_sid,main.sales_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.acct_mgr_district_nr) AS acct_mgr_district_nr
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_name ,
        main.sales_region_sid,main.sales_region_name,
        main.country_org_sid,'Unbekannt',
        main.acct_mgr_district_name) AS acct_mgr_district_name
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_company_director_emp_sid ,
        main.sales_region_sid,main.sales_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.acct_mgr_emp_sid) AS acct_mgr_emp_sid
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_mgr_emp_nr,
        main.sales_region_sid,main.sales_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.acct_mgr_emp_nr) AS acct_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.sales_company_sid,main.sales_mgr_name,
        main.sales_region_sid,main.sales_region_mgr_name,
        main.country_org_sid,'Unbekannt',
        main.acct_mgr_name) AS acct_mgr_name
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_company_sid) AS sales_company_sid
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.sales_company_nr) AS sales_company_nr
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_name,
        main.country_org_sid,'Unbekannt',
        main.sales_company_name) AS sales_company_name
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_mgr_emp_sid) AS sales_company_director_emp_sid
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.sales_mgr_emp_nr) AS sales_company_director_emp_nr
,DECODE(main.int_org_sid,
        main.sales_region_sid,main.sales_region_mgr_name,
        main.country_org_sid,'Unbekannt',
        main.sales_company_director_name) AS sales_company_director_name   
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_sid,
        main.country_org_sid,main.country_org_sid,
        main.deliv_company_sid) AS deliv_company_sid
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_nr,
        main.country_org_sid,main.country_org_nr,
        main.deliv_company_nr) AS deliv_company_nr
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_name,
        main.country_org_sid,'Unbekannt',
        main.deliv_company_name) AS deliv_company_name
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_mgr_emp_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.deliv_company_director_emp_sid) AS deliv_company_director_emp_sid
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_mgr_emp_nr,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.deliv_company_director_emp_nr) AS deliv_company_director_emp_nr
,DECODE(main.int_org_sid,
        main.deliv_region_sid,main.deliv_region_mgr_name,
        main.country_org_sid,'Unbekannt',
        main.deliv_company_director_name) AS deliv_company_director_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.expansion_company_sid) AS expansion_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.expansion_company_nr) AS expansion_company_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,'Unbekannt',
        main.expansion_company_name) AS expansion_company_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.bal_sheet_company_sid) AS bal_sheet_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.bal_sheet_company_nr) AS bal_sheet_company_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,'Unbekannt',
        main.bal_sheet_company_name) AS bal_sheet_company_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.owner_company_sid) AS owner_company_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.owner_company_nr) AS owner_company_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,'Unbekannt',
        main.owner_company_name) AS owner_company_name
,main.country_org_sid AS country_org_sid
,main.country_org_cd AS country_org_cd
,main.country_org_nr AS country_org_nr
,main.country_org_name AS country_org_name
,main.legal_name AS legal_name 
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
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.deliv_region_mgr_emp_nr) AS deliv_region_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.deliv_region_mgr_emp_sid) AS deliv_region_mgr_emp_sid       
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_name,
        main.deliv_region_mgr_name) AS deliv_region_mgr_name
,DECODE(main.int_org_sid,
        main.country_org_sid,'Unbekannt',
        main.deliv_region_name) AS deliv_region_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.deliv_region_nr) AS deliv_region_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.deliv_region_sid) AS deliv_region_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_nr,
        main.sales_region_mgr_emp_nr) AS sales_region_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_region_mgr_emp_sid) AS sales_region_mgr_emp_sid       
,DECODE(main.int_org_sid,
        main.country_org_sid,'Unbekannt',
        main.sales_region_mgr_name) AS sales_region_mgr_name
,DECODE(main.int_org_sid,
        main.country_org_sid,'Unbekannt',
        main.sales_region_name) AS sales_region_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.sales_region_nr) AS sales_region_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_region_sid) AS sales_region_sid
FROM  CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 main 
WHERE main.dwh_valid_fg = TRUE 
AND main.int_org_type_cd NOT IN ('COUNTRY_GRP','TRUST')
AND main.int_org_status_cd NOT IN ('PRE-PROCESS');