create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_SALES_MANAGER_DISTRICT_2(
	SALES_MGR_DISTRICT_SID COMMENT 'the unique identifier (surrogate key) for the organizational unit_2 for which a sales_2 manager is responsible.',
	INT_ORG_TYPE_CD COMMENT 'the internal organization type like store,country_2',
	DWH_VALID_FROM_TMSP COMMENT 'the point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'the point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SALES_MGR_DISTRICT_NR COMMENT 'the number which identifies the organizational unit_2 for which a sales_2 manager is responsible.',
	SALES_MGR_DISTRICT_NAME COMMENT 'the name of the sales_2 manager district.',
	SALES_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2, who is currently filling the position of the sales_2 manager.',
	SALES_MGR_EMP_NR COMMENT 'the employee_2 number of the person who is currently filling the position of the sales_2 manager.',
	SALES_MGR_NAME COMMENT 'the name of the person who is currently filling the position of the sales_2 manager.',
	INT_ORG_STATUS_CD COMMENT 'the code for the lifecycle status_2 of an internal organization.',
	INT_ORG_STATUS_DESCR COMMENT 'a textual description for the lifecycle status_2 of an internal organization in group language, i.e. in german.',
	ISO_COUNTRY_CD COMMENT 'the code according to iso 3166 identifying the country_2, in which the office of the sales_2 manager is located,',
	COUNTRY_NAME COMMENT 'the name of the country_2, in which the office of the sales_2 manager  is located,',
	CITY_NAME COMMENT 'the name of the city where the office of the sales_2 manager is located.',
	DISTRICT_NAME COMMENT 'the name of the district, in which the office of the sales_2 manager is located,',
	ZIP COMMENT 'the postal code of the office of the sales_2 manager .',
	STREET_NAME COMMENT 'the name of the street where the office of the sales_2 manager is located.',
	HOUSE_NR COMMENT 'the number of the building within the street where the office of the sales_2 manager is located.',
	LON COMMENT 'the geographical longitude of the office address_2 of the sales_2 manager.',
	LAT COMMENT 'the geographical latitude of the office address_2 of the sales_2 manager.',
	ACCT_MGR_DISTRICT_SID COMMENT 'the unique identifier (surrogate key) for the organizational unit_2 for which the related account_2 manager is responsible.',
	ACCT_MGR_DISTRICT_NR COMMENT 'the number which identifies the organizational unit_2 for which the related account_2 manager is responsible.',
	ACCT_MGR_DISTRICT_NAME COMMENT 'the name of the related account_2 manager district.',
	ACCT_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2, who is currently filling the positon of the related account_2 manager.',
	ACCT_MGR_EMP_NR COMMENT 'the employee_2 number of the person who is currently filling the position of the related account_2 manager.',
	ACCT_MGR_NAME COMMENT 'the name of the person who is currently filling the position of the related account_2 manager.',
	SALES_COMPANY_SID COMMENT 'the unique identifier (surrogate key) for the sales_2 company (vges) to which this sales_2 manager district is related.',
	SALES_COMPANY_NR COMMENT 'the number which identifies the sales_2 company (vges) to which this sales_2 manager district is related.',
	SALES_COMPANY_NAME COMMENT 'the name of the sales_2 company to which this sales_2 manager district is related..',
	SALES_COMPANY_DIRECTOR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2, who is the director of the related sales_2 company.',
	SALES_COMPANY_DIRECTOR_EMP_NR COMMENT 'the employee_2 number of the director of the related sales_2 company.',
	SALES_COMPANY_DIRECTOR_NAME COMMENT 'the name of the manager of the related sales_2 company.',
	COUNTRY_ORG_SID COMMENT 'the unique identifier (surrogate key) for the related country_2 organization.',
	COUNTRY_ORG_CD COMMENT 'the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)',
	COUNTRY_ORG_NR COMMENT 'the number which identifies the related country_2 organization.',
	COUNTRY_ORG_NAME COMMENT 'the name for the related country_2 organization. (name in group language, i.e. in german). (the country_2 organization is not necessarily identical with a political country_2,)',
	LEGAL_NAME COMMENT 'the name for the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_ORG_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2 who is responsible for the related country_2 organization.',
	COUNTRY_ORG_MGR_EMP_NR COMMENT 'the employee_2 number of the manager who is responsible for the related country_2 organization.',
	COUNTRY_ORG_MGR_NAME COMMENT 'the name of the manager who is responsible for the related country_2 organization.',
	COUNTRY_GRP_ORG_SID COMMENT 'the unique identifier (surrogate key) for the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NR COMMENT 'the number which identifies the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_NAME COMMENT 'the name for the related organizational unit_2 which oversees the business in a group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2 who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_EMP_NR COMMENT 'the employee_2 number of the manager who is responsible for the related group of countries.',
	COUNTRY_GRP_ORG_MGR_NAME COMMENT 'the name of the manager who is responsible for the related group of countries.',
	DWH_CREATED_TMSP COMMENT 'the point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'the point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'the code for the source system (or slice of source system) from which this record was loaded.',
	SALES_REGION_MGR_EMP_NR COMMENT 'the employee_2 number of the person who is currently filling the role of the manager of the related sales_2 region.',
	SALES_REGION_MGR_EMP_SID COMMENT 'the unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related sales_2 region.',
	SALES_REGION_MGR_NAME COMMENT 'the name of the manager of the related sales_2 region.',
	SALES_REGION_NAME COMMENT 'the name of the related sales_2 region.',
	SALES_REGION_NR COMMENT 'the number which identifies the related sales_2 region.',
	SALES_REGION_SID COMMENT 'the unique identifier (surrogate key) for the related sales_2 region_2'
) COMMENT='A sales_2 manager is responsible for a group of stores.This organizational unit_2 is the first management level above the store manager.. (The person who is acting AS the sales_2 manager may change over time. This dimension describes the internal organization.)'
 as SELECT
 main.int_org_sid AS sales_mgr_district_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_2',
        main.int_org_type_cd) AS int_org_type_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS sales_mgr_district_nr
,main.int_org_name AS sales_mgr_district_name
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
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_mgr_name) AS sales_mgr_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
,main.iso_country_cd AS iso_country_cd
,main.country_name AS country_name
,main.city_name AS city_name
,main.district_name AS district_name
,main.zip AS zip
,main.street_name AS street_name
,main.house_nr AS house_nr
,main.lon AS lon
,main.lat AS lat
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
        main.country_org_sid,main.country_org_name,
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
        main.country_org_sid,main.country_org_mgr_name,
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
        main.country_org_sid,main.country_org_name,
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
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_company_director_name) AS sales_company_director_name
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
        main.sales_region_mgr_emp_nr) AS sales_region_mgr_emp_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_region_mgr_emp_sid) AS sales_region_mgr_emp_sid       
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_region_mgr_name) AS sales_region_mgr_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.sales_region_name) AS sales_region_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.sales_region_nr) AS sales_region_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_region_sid) AS sales_region_sid
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 main 
WHERE main.dwh_valid_fg = TRUE 
 AND main.int_org_type_cd NOT IN ('STORE','COUNTRY_GRP','TRUST') 
 AND main.int_org_status_cd NOT IN ('PRE-PROCESS');