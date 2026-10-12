CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_account_manager_district_2 (acct_mgr_district_sid
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit_2 for which an account_2 manager is responsible.'),
int_org_type_cd OPTIONS(description='The internal organization type like store,company ...'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
acct_mgr_district_nr
OPTIONS(description='The number which identifies the organizational unit_2 for which an account_2 manager is responsible.'),
acct_mgr_district_name OPTIONS(description='The name of the account_2 manager district.'), acct_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who is currently filling the role of the account_2 manager..'),
acct_mgr_emp_nr
OPTIONS(description='The employee_2 number of the person who is currently filling the position of the account_2 manager.'),
acct_mgr_name
OPTIONS(description='The name of the person who is currently filling the position of the account_2 manager.'),
int_org_status_cd OPTIONS(description='The code for the lifecycle status_2 of an internal organization.'),
int_org_status_descr
OPTIONS(description='A textual description for the lifecycle status_2 of an internal organization in group language, i.e. in German.'),
iso_country_cd
OPTIONS(description='The code according to ISO 3166 identifying the country_2, in which the office of the account_2 manager is located,'),
country_name OPTIONS(description='The name of the country_2, in which the office of the account_2 manager is located,'),
city_name OPTIONS(description='The name of the city where the office of the account_2 manager is located.'), district_name
OPTIONS(description='The name of the district, in which the office of the account_2 manager is located,'), zip
OPTIONS(description='The postal code of the office address_2 of the account_2 manager.'), street_name
OPTIONS(description='The name of the street where the office of the account_2 manager is located.'), house_nr
OPTIONS(description='The number of the building within the street where the office of the account_2 manager is located.'),
lon OPTIONS(description='The geographical longitude of the office address_2 of the account_2 manager.'), lat
OPTIONS(description='The geographical latitude of the office address_2 of the account_2 manager.'), sales_company_sid
OPTIONS(description='The unique identifier (surrogate key) for the sales_2 company (VGES) to which this account_2 manager district is related.'),
sales_company_nr
OPTIONS(description='The number which identifies the sales_2 company (VGES) to which this account_2 manager district is related.'),
sales_company_name
OPTIONS(description='The name of the sales_2 company to which this account_2 manager district is related..'),
sales_company_director_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who is the director of the related sales_2 company.'),
sales_company_director_emp_nr OPTIONS(description='The employee_2 number of the director of the related sales_2 company.'),
sales_company_director_name OPTIONS(description='The name of the manager of the related sales_2 company.'),
country_org_sid OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
country_org_nr OPTIONS(description='The number which identifies the related country_2 organization.'), country_org_name
OPTIONS(description='The name for the related country_2 organization. (name in group language, i.e. in German). (The country_2 organization is not necessarily identical with a political country_2,)'),
legal_name
OPTIONS(description='The official name of the company which acts AS the country_2 organization, AS shown in the company register.'),
country_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who is responsible for the related country_2 organization.'),
country_org_mgr_emp_nr
OPTIONS(description='The employee_2 number of the manager who is responsible for the related country_2 organization.'),
country_org_mgr_name
OPTIONS(description='The name of the manager who is responsible for the related country_2 organization.'),
country_grp_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_nr
OPTIONS(description='The number which identifies the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='The name for the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='The employee_2 number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name
OPTIONS(description='The name of the manager who is responsible for the related group of countries.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
sales_region_mgr_emp_nr
OPTIONS(description='The employee_2 number of the person who is currently filling the role of the manager of the related sales_2 region.'),
sales_region_mgr_name OPTIONS(description='The name of the manager of the related sales_2 region.'),
sales_region_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related sales_2 region.'),
sales_region_name OPTIONS(description='The name of the related sales_2 region.'), sales_region_nr
OPTIONS(description='The number which identifies the related sales_2 region.'), sales_region_sid
OPTIONS(description='The unique identifier (surrogate key) for the related sales_2 region_2'))
OPTIONS(DESCRIPTION = `AN ACCOUNT_2 MANAGER OVERSEES A GROUP OF SALES_2 MANAGERS. THIS ORGANIZATIONAL UNIT_2 IS THE SECOND MANAGEMENT LEVEL ABOVE THE STORE MANAGER.(THE PERSON WHO IS ACTING AS THE ACCOUNT_2 MANAGER MAY CHANGE OVER TIME. THIS DIMENSION DESCRIBES THE INTERNAL ORGANIZATION.)`)
AS SELECT int_org_sid AS acct_mgr_district_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'COUNTRY_2'
  ELSE CAST(int_org_type_cd AS STRING)
  END AS int_org_type_cd,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 curr_int_org_nr AS acct_mgr_district_nr,
 int_org_name AS acct_mgr_district_name,
  CASE
  WHEN int_org_sid = sales_company_sid
  THEN sales_company_director_emp_sid
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_emp_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_sid
  ELSE acct_mgr_emp_sid
  END AS acct_mgr_emp_sid,
  CASE
  WHEN int_org_sid = sales_company_sid
  THEN sales_mgr_emp_nr
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_emp_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_nr
  ELSE acct_mgr_emp_nr
  END AS acct_mgr_emp_nr,
  CASE
  WHEN int_org_sid = sales_company_sid
  THEN sales_mgr_name
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_name
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_name
  ELSE acct_mgr_name
  END AS acct_mgr_name,
 int_org_status_cd,
 int_org_status_descr,
 iso_country_cd,
 country_name,
 city_name,
 district_name,
 zip,
 street_name,
 house_nr,
 lon,
 lat,
  CASE
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE sales_company_sid
  END AS sales_company_sid,
  CASE
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE sales_company_nr
  END AS sales_company_nr,
  CASE
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_name
  WHEN int_org_sid = country_org_sid
  THEN country_org_name
  ELSE sales_company_name
  END AS sales_company_name,
  CASE
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_emp_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_sid
  ELSE sales_mgr_emp_sid
  END AS sales_company_director_emp_sid,
  CASE
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_emp_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_nr
  ELSE sales_mgr_emp_nr
  END AS sales_company_director_emp_nr,
  CASE
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_name
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_name
  ELSE sales_company_director_name
  END AS sales_company_director_name,
 country_org_sid,
 country_org_cd,
 country_org_nr,
 country_org_name,
 legal_name,
 country_org_mgr_emp_sid,
 country_org_mgr_emp_nr,
 country_org_mgr_name,
 country_grp_org_sid,
 country_grp_org_nr,
 country_grp_org_name,
 country_grp_org_mgr_emp_sid,
 country_grp_org_mgr_emp_nr,
 country_grp_org_mgr_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_nr
  ELSE sales_region_mgr_emp_nr
  END AS sales_region_mgr_emp_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_name
  ELSE sales_region_mgr_name
  END AS sales_region_mgr_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_sid
  ELSE sales_region_mgr_emp_sid
  END AS sales_region_mgr_emp_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_name
  ELSE sales_region_name
  END AS sales_region_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE sales_region_nr
  END AS sales_region_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE sales_region_sid
  END AS sales_region_sid
FROM ldl_data_core_dim.t_dim_internal_organization_2 AS MAIN
WHERE dwh_valid_fg
 AND int_org_type_cd NOT IN ('STORE', 'SALES_MANAGER', 'COUNTRY_GRP', 'TRUST')
 AND int_org_status_cd NOT IN ('PRE-PROCESS');