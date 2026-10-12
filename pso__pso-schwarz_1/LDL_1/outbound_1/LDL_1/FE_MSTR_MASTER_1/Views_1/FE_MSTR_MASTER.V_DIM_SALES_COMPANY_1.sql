CREATE OR REPLACE VIEW fe_mstr_master.v_dim_sales_company_1 (sales_company_sid
OPTIONS(description='the unique identifier (surrogate key) for a sales_1 company (vges).'), int_org_type_cd
OPTIONS(description='the internal organization type like store,company...'), dwh_valid_from_tmsp
OPTIONS(description='the point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='the point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sales_company_nr OPTIONS(description='the number which identifies the sales_1 company.'), sales_company_name
OPTIONS(description='the name of the sales_1 company.'), int_org_status_cd
OPTIONS(description='the code for the lifecycle status_1 of an internal organization.'), int_org_status_descr
OPTIONS(description='a textual description for the lifecycle status_1 of an internal organization in group language, i.e. in german.'),
open_dt
OPTIONS(description='the date when the sales_1 company has started its regular operation. (this date may be different from the planned opening date.)'),
planned_open_dt OPTIONS(description='the expected opening date of the sales_1 company.'), close_dt
OPTIONS(description='the date when the sales_1 company has stopped its regular operation.'), iso_country_cd
OPTIONS(description='the code identifying the country_1 according to iso 3166.'), country_name
OPTIONS(description='the name of the country_1, in which the sales_1 company is located,'), city_name
OPTIONS(description='the name of the city where the sales_1 company is located.'), district_name
OPTIONS(description='the name of the district, in which the sales_1 company is located,'), zip
OPTIONS(description='the postal code of the address_1 of the sales_1 company.'), street_name
OPTIONS(description='the name of the street where the sales_1 company is located.'), house_nr
OPTIONS(description='the number of the building within the street where the sales_1 company is located.'), lon
OPTIONS(description='the geographical longitude of the address_1 of the sales_1 company.'), lat
OPTIONS(description='the geographical latitude of the address_1 of the sales_1 company.'), po_box_nr
OPTIONS(description='the post box number of the sales_1 company. (null if it does not have post box.)'), phone_nr
OPTIONS(description='the telephone number of the sales_1 company.'), fax_nr
OPTIONS(description='the telefax number of the sales_1 company.'), email_addr_txt
OPTIONS(description='an email address_1 for that sales_1 company.'), sales_company_director_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1, who is currently filling the role of the director of the sales_1 company.'),
sales_company_director_emp_nr
OPTIONS(description='the employee_1 number of the person who is currently filling the position of the director of the sales_1 company.'),
sales_company_director_name
OPTIONS(description='the name of the person who is currently filling the position of the director of the sales_1 company.'),
country_org_sid OPTIONS(description='the unique identifier (surrogate key) for the related country_1 organization.'),
country_org_cd
OPTIONS(description='the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)'),
country_org_nr OPTIONS(description='the number which identifies the related country_1 organization.'), country_org_name
OPTIONS(description='the name for the related country_1 organization. (name in group language, i.e. in german). (the country_1 organization is not necessarily identical with a political country_1)'),
country_org_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1 who is responsible for the related country_1 organization.'),
country_org_mgr_emp_nr
OPTIONS(description='the employee_1 number of the manager who is responsible for the related country_1 organization.'),
country_org_mgr_name
OPTIONS(description='the name of the manager who is responsible for the related country_1 organization.'),
country_grp_org_sid
OPTIONS(description='the unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_nr
OPTIONS(description='the number which identifies the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='the name for the related organizational unit_1 which oversees the business in a group of countries.'),
legal_name
OPTIONS(description='the name for the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='the employee_1 number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name
OPTIONS(description='the name of the manager who is responsible for the related group of countries.'), dwh_created_tmsp
OPTIONS(description='the point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='the point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='the unique identifier of the batch load which has done the last update to this record. (closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='the code for the source system (or slice of source system) from which this record was loaded.'),
sales_region_mgr_emp_nr
OPTIONS(description='The employee_1 number of the person who is currently filling the role of the manager of the related sales_1 region.'),
sales_region_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related sales_1 region.'),
sales_region_mgr_name OPTIONS(description='The name of the manager of the related sales_1 region.'), sales_region_name
OPTIONS(description='The name of the related sales_1 region.'), sales_region_nr
OPTIONS(description='The number which identifies the related sales_1 region.'), sales_region_sid
OPTIONS(description='The unique identifier (surrogate key) for the related sales_1 region_1'))
OPTIONS(DESCRIPTION = `THE SALES_1 COMPANY HANDLES ALL RETAIL-RELATED ASPECTS OF A REGIONAL COMPANY. IT IS PART OF THE SALES_1 HIERARCHY.. ALSO KNOWN AS VGES.`)
AS SELECT int_org_sid AS sales_company_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'COUNTRY_1'
  ELSE CAST(int_org_type_cd AS STRING)
  END AS int_org_type_cd,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 curr_int_org_nr AS sales_company_nr,
 int_org_name AS sales_company_name,
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
  THEN country_org_mgr_emp_sid
  ELSE sales_region_mgr_emp_sid
  END AS sales_region_mgr_emp_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_name
  ELSE sales_region_mgr_name
  END AS sales_region_mgr_name,
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
FROM ldl_data_core_dim.t_dim_internal_organization_1 AS MAIN
WHERE dwh_valid_fg
 AND (int_org_type_cd = 'COMPANY' AND is_sales_company_fg OR int_org_type_cd = 'REGION_1' OR int_org_type_cd = 'COMPANY'
    AND int_org_sid = country_org_sid);