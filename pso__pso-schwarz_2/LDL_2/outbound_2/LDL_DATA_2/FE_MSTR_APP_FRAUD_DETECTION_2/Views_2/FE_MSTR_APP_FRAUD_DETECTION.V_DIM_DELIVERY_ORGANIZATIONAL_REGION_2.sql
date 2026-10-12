CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_delivery_organizational_region_2 (dwh_valid_from_tmsp
OPTIONS(description='the point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='the point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
int_org_type_cd OPTIONS(description='the internal organization type like store,company...'), int_org_status_cd
OPTIONS(description='the code for the lifecycle status_2 of an internal organization.'), int_org_status_descr
OPTIONS(description='a textual description for the lifecycle status_2 of an internal organization in group language, i.e. in german.'),
iso_country_cd
OPTIONS(description='the code according to iso 3166 identifying the country_2, in which the head office for the organizational region_2 is located,'),
country_name
OPTIONS(description='the name of the country_2, in which the head office for the organizational region_2 is located,'),
city_name OPTIONS(description='the name of the city where the head office for the organizational region_2 is located.'),
district_name
OPTIONS(description='the name of the district, in which the head office for the organizational region_2 is located,'), zip
OPTIONS(description='the postal code of the address_2 of the head office for the organizational region.'), street_name
OPTIONS(description='the name of the street where the head office for the organizational region_2 is located.'), house_nr
OPTIONS(description='the number of the building within the street where the head office for the organizational region_2 is located.'),
lon OPTIONS(description='the geographical longitude of the head office for the organizational region.'), lat
OPTIONS(description='the geographical latitude of the head office for the organizational region.'), country_org_sid
OPTIONS(description='the unique identifier (surrogate key) for the country_2 organization to which this organizational region_2 reports.'),
country_org_cd
OPTIONS(description='the code of the business country_2 for which this country_2 organization is responsible. (the business country_2 is not identical to a political country.)'),
country_org_nr
OPTIONS(description='the number which identifies the country_2 organization to which this organizational region_2 reports.'),
country_org_name
OPTIONS(description='the name for the country_2 organization to which this organizational region_2 reports. (name in group language, i.e. in german). (the country_2 organization is not necessarily identical with a political country_2,)'),
legal_name
OPTIONS(description='the official name of the company which acts as the country_2 organization, as shown in the company register.'),
country_org_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_2 who is responsible for the related country_2 organization.'),
country_org_mgr_emp_nr
OPTIONS(description='the employee_2 number of the manager who is responsible for the related country_2 organization.'),
country_org_mgr_name
OPTIONS(description='the name of the manager who is responsible for the related country_2 organization.'),
country_grp_org_sid
OPTIONS(description='the unique identifier (surrogate key) for the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_nr
OPTIONS(description='the number which identifies the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='the name for the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_2 who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='the employee_2 number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name
OPTIONS(description='the name of the manager who is responsible for the related group of countries.'), dwh_created_tmsp
OPTIONS(description='the point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='the point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='the code for the source system (or slice of source system) from which this record was loaded.'),
deliv_region_mgr_emp_nr
OPTIONS(description='the employee_2 number of the person who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_name OPTIONS(description='the name of the manager of the related delivery region.'), deliv_region_name
OPTIONS(description='the name of the related delivery region.'), deliv_region_nr
OPTIONS(description='the number which identifies the related delivery region.'), deliv_region_sid
OPTIONS(description='the unique identifier (surrogate key) for the related delivery region_2'))
OPTIONS(DESCRIPTION = `AN ORGANIZATIONAL UNIT_2 WHICH OVERSEES THE BUSINESS IN A REGION. A REGION_2 IS TYPICALLY A PART OF A COUNTRY.`)
AS SELECT dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 int_org_type_cd,
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
  ELSE deliv_region_mgr_emp_nr
  END AS deliv_region_mgr_emp_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_sid
  ELSE deliv_region_mgr_emp_sid
  END AS deliv_region_mgr_emp_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_name
  ELSE deliv_region_mgr_name
  END AS deliv_region_mgr_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_name
  ELSE deliv_region_name
  END AS deliv_region_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE deliv_region_nr
  END AS deliv_region_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE deliv_region_sid
  END AS deliv_region_sid
FROM ldl_data_core_dim.t_dim_internal_organization_2 AS MAIN
WHERE dwh_valid_fg
 AND (int_org_type_cd = 'REGION_2' OR int_org_type_cd = 'COMPANY' AND int_org_sid = country_org_sid)
 AND int_org_status_cd NOT IN ('PRE-PROCESS');