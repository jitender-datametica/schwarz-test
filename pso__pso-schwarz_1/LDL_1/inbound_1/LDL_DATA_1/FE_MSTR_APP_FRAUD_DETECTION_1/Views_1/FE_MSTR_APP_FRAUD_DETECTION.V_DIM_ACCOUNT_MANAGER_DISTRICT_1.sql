CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_ACCOUNT_MANAGER_DISTRICT_1(
acct_mgr_district_sid COMMENT 'The unique identifier (surrogate key) for the organizational unit_1 for which an account_1 manager is responsible.'
,int_org_type_cd COMMENT 'The internal organization type like store,company ...'
,dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,acct_mgr_district_nr COMMENT 'The number which identifies the organizational unit_1 for which an account_1 manager is responsible.'
,acct_mgr_district_name COMMENT 'The name of the account_1 manager district.'
,acct_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee_1, who is currently filling the role of the account_1 manager..'
,acct_mgr_emp_nr COMMENT 'The employee_1 number of the person who is currently filling the position of the account_1 manager.'
,acct_mgr_name COMMENT 'The name of the person who is currently filling the position of the account_1 manager.'
,int_org_status_cd COMMENT 'The code for the lifecycle status_1 of an internal organization.'
,int_org_status_descr COMMENT 'A textual description for the lifecycle status_1 of an internal organization in group language, i.e. in German.'
,ISO_COUNTRY_CD COMMENT 'The code according to ISO 3166 identifying the country_1, in which the office of the account_1 manager is located,'
,country_name COMMENT 'The name of the country_1, in which the office of the account_1 manager is located,'
,city_name COMMENT 'The name of the city where the office of the account_1 manager is located.'
,district_name COMMENT 'The name of the district, in which the office of the account_1 manager is located,'
,zip COMMENT 'The postal code of the office address_1 of the account_1 manager.'
,street_name COMMENT 'The name of the street where the office of the account_1 manager is located.'
,house_nr COMMENT 'The number of the building within the street where the office of the account_1 manager is located.'
,lon COMMENT 'The geographical longitude of the office address_1 of the account_1 manager.'
,lat COMMENT 'The geographical latitude of the office address_1 of the account_1 manager.'
,sales_company_sid COMMENT 'The unique identifier (surrogate key) for the sales_1 company (VGES) to which this account_1 manager district is related.'
,sales_company_nr COMMENT 'The number which identifies the sales_1 company (VGES) to which this account_1 manager district is related.'
,sales_company_name COMMENT 'The name of the sales_1 company to which this account_1 manager district is related..'
,sales_company_director_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee_1, who is the director of the related sales_1 company.'
,sales_company_director_emp_nr COMMENT 'The employee_1 number of the director of the related sales_1 company.'
,sales_company_director_name COMMENT 'The name of the manager of the related sales_1 company.'
,country_org_sid COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.'
,country_org_cd COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'
,country_org_nr COMMENT 'The number which identifies the related country_1 organization.'
,country_org_name COMMENT 'The name for the related country_1 organization. (name in group language, i.e. in German). (The country_1 organization is not necessarily identical with a political country_1,)'
,legal_name COMMENT 'The official name of the company which acts AS the country_1 organization, AS shown in the company register.'
,country_org_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee_1 who is responsible for the related country_1 organization.'
,country_org_mgr_emp_nr COMMENT 'The employee_1 number of the manager who is responsible for the related country_1 organization.'
,country_org_mgr_name COMMENT 'The name of the manager who is responsible for the related country_1 organization.'
,country_grp_org_sid COMMENT 'The unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.'
,country_grp_org_nr COMMENT 'The number which identifies the related organizational unit_1 which oversees the business in a group of countries.'
,country_grp_org_name COMMENT 'The name for the related organizational unit_1 which oversees the business in a group of countries.'
,country_grp_org_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.'
,country_grp_org_mgr_emp_nr COMMENT 'The employee_1 number of the manager who is responsible for the related group of countries.'
,country_grp_org_mgr_name COMMENT 'The name of the manager who is responsible for the related group of countries.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
,sales_region_mgr_emp_nr COMMENT 'The employee_1 number of the person who is currently filling the role of the manager of the related sales_1 region.'
,sales_region_mgr_name COMMENT 'The name of the manager of the related sales_1 region.'
,sales_region_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related sales_1 region.'
,sales_region_name COMMENT 'The name of the related sales_1 region.'
,sales_region_nr COMMENT 'The number which identifies the related sales_1 region.'
,sales_region_sid COMMENT 'The unique identifier (surrogate key) for the related sales_1 region_1'
) COMMENT='An account_1 manager oversees a group of sales_1 managers. This organizational unit_1 is the second management level above the store manager.(The person who is acting AS the account_1 manager may change over time. This dimension describes the internal organization.)' AS SELECT 
main.int_org_sid AS acct_mgr_district_sid
,DECODE(main.int_org_sid,
        main.country_org_sid,'COUNTRY_1',
        main.int_org_type_cd) AS int_org_type_cd
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS acct_mgr_district_nr
,main.int_org_name AS acct_mgr_district_name
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
        main.country_org_sid,main.country_org_mgr_name,
        main.sales_region_mgr_name) AS sales_region_mgr_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_mgr_emp_sid,
        main.sales_region_mgr_emp_sid) AS sales_region_mgr_emp_sid       
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_name,
        main.sales_region_name) AS sales_region_name
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_nr,
        main.sales_region_nr) AS sales_region_nr
,DECODE(main.int_org_sid,
        main.country_org_sid,main.country_org_sid,
        main.sales_region_sid) AS sales_region_sid 
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1 main 
WHERE main.dwh_valid_fg = TRUE 
AND main.int_org_type_cd NOT IN ('STORE','SALES_MANAGER','COUNTRY_GRP','TRUST')
AND main.int_org_status_cd  NOT IN ('PRE-PROCESS');