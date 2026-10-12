CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_delivery_company (deliv_company_sid
OPTIONS(description='the unique identifier (surrogate key) for delivery company.'), int_org_type_cd
OPTIONS(description='the internal company type like store,company...'), dwh_valid_from_tmsp
OPTIONS(description='the point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='the point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
deliv_company_nr OPTIONS(description='the number which identifies the delivery company.'), deliv_company_name
OPTIONS(description='the name of the delivery company.'), int_org_status_cd
OPTIONS(description='the code for the lifecycle status of an internal organization.'), int_org_status_descr
OPTIONS(description='a textual description for the lifecycle status of an internal organization in group language, i.e. in german.'),
open_dt
OPTIONS(description='the date when the delivery company has started its regular operation. (this date may be different from the planned opening date.)'),
planned_open_dt OPTIONS(description='the expected opening date of the delivery company.'), close_dt
OPTIONS(description='the date when the delivery company has stopped its regular operation.'), iso_country_cd
OPTIONS(description='the code identifying the country according to iso 3166.'), country_name
OPTIONS(description='the name of the country, in which the delivery company is located,'), city_name
OPTIONS(description='the name of the city where the delivery company is located.'), district_name
OPTIONS(description='the name of the district, in which the delivery company is located,'), zip
OPTIONS(description='the postal code of the address of the delivery company.'), street_name
OPTIONS(description='the name of the street where the delivery company is located.'), house_nr
OPTIONS(description='the number of the building within the street where the delivery company is located.'), lon
OPTIONS(description='the geographical longitude of the address of the delivery company.'), lat
OPTIONS(description='the geographical latitude of the address of the delivery company.'), po_box_nr
OPTIONS(description='the post box number of the delivery company (null if it does not have post box.)'), phone_nr
OPTIONS(description='the telephone number of the delivery company.'), fax_nr
OPTIONS(description='the telefax number of the delivery company.'), email_addr_txt
OPTIONS(description='an email address for that delivery company.'), deliv_company_director_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee, who is currently filling the role of the director of the delivery company.'),
deliv_company_director_emp_nr
OPTIONS(description='the employee number of the person who is currently filling the position of the director of the delivery company-'),
deliv_company_director_name
OPTIONS(description='the name of the person who is currently filling the position of the director of the delivery company.'),
country_org_sid OPTIONS(description='the unique identifier (surrogate key) for the related country organization.'),
country_org_cd
OPTIONS(description='the code of the business country for which this country organization is responsible. (the business country is not identical to a political country.)'),
country_org_nr OPTIONS(description='the number which identifies the related country organization.'), country_org_name
OPTIONS(description='the name for the related  country organization (name in group language, i.e. in german). (the country organization is not necessarily identical with a political country,)'),
legal_name
OPTIONS(description='the official name of the company which acts as the country organization, as shown in the company register.'),
country_org_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee who is responsible for the related country organization.'),
country_org_mgr_emp_nr
OPTIONS(description='the employee number of the manager who is responsible for the related country organization.'),
country_org_mgr_name
OPTIONS(description='the name of the manager who is responsible for the related country organization.'),
country_grp_org_sid
OPTIONS(description='the unique identifier (surrogate key) for the related organizational unit which oversees the business in a group of countries.'),
country_grp_org_nr
OPTIONS(description='the number which identifies the related organizational unit which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='the name for the related organizational unit which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='the employee number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name
OPTIONS(description='the name of the manager who is responsible for the related group of countries.'), dwh_created_tmsp
OPTIONS(description='the point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='the point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='the code for the source system (or slice of source system) from which this record was loaded.'),
deliv_region_mgr_emp_nr
OPTIONS(description='the employee number of the person who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_name OPTIONS(description='the name of the manager of the related delivery region.'), deliv_region_name
OPTIONS(description='the name of the related delivery region.'), deliv_region_sid
OPTIONS(description='the unique identifier (surrogate key) for the related delivery region'), deliv_region_nr
OPTIONS(description='the number which identifies the related delivery region.'))
OPTIONS(DESCRIPTION = `THE DELIVERY COMPANY IS RESPONSIBLE FOR PROVIDING ITEMS TO THE STORES. IT OPERATES A WAREHOUSE. THE DELIVERY COMPANY IS PART OF THE DELIVERY HIERARCHY. ALSO KNOWN AS BGES.`)
AS SELECT int_org_sid AS deliv_company_sid,
 int_org_type_cd,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 curr_int_org_nr AS deliv_company_nr,
 int_org_name AS deliv_company_name,
 int_org_status_cd,
 int_org_status_descr,
 open_dt,
 planned_open_dt,
 close_dt,
 iso_country_cd,
 country_name,
 city_name,
 district_name,
 zip,
 street_name,
 house_nr,
 lon,
 lat,
 po_box_nr,
 phone_nr,
 fax_nr,
 email_addr_txt,
  CASE
  WHEN int_org_sid = deliv_region_sid
  THEN deliv_region_mgr_emp_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_sid
  ELSE deliv_company_director_emp_sid
  END AS deliv_company_director_emp_sid,
  CASE
  WHEN int_org_sid = deliv_region_sid
  THEN deliv_region_mgr_emp_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_nr
  ELSE deliv_company_director_emp_nr
  END AS deliv_company_director_emp_nr,
  CASE
  WHEN int_org_sid = deliv_region_sid
  THEN deliv_region_mgr_name
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_name
  ELSE deliv_company_director_name
  END AS deliv_company_director_name,
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
FROM ldl_data_core_dim.t_dim_internal_organization AS MAIN
WHERE dwh_valid_fg
 AND (int_org_type_cd = 'COMPANY' AND is_deliv_company_fg OR int_org_type_cd = 'REGION' OR int_org_type_cd = 'COMPANY'
    AND int_org_sid = country_org_sid)
 AND int_org_status_cd NOT IN ('PRE-PROCESS');