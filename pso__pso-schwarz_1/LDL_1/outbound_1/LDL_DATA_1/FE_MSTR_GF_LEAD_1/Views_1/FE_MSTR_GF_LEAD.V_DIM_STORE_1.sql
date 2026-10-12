CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_store_1 (store_sid
OPTIONS(description='the unique identifier (surrogate key) for a store.'), int_org_type_cd
OPTIONS(description='the internal organanisation type like store, company...'), dwh_valid_from_tmsp
OPTIONS(description='the point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='the point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
curr_store_nr
OPTIONS(description='the number by which the store is currently known to business. the store number is identical to the real estate number of the object which currently houses the store. in case the building changes, the store_sid remains unchanged, but the store number gets updated.'),
init_store_nr
OPTIONS(description='the initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. this number does not change, in case the building changes.'),
store_name OPTIONS(description='the name of the store.'), int_org_status_cd
OPTIONS(description='the code for the retail status_1 of a store. the status_1 codes for <open> and <closed> are strictly connected with the store open date and the store close date, AS they are derived from these attributes.'),
int_org_status_descr
OPTIONS(description='a textual description for the retail status_1 (open / closed) of a store in group language, i.e. in german.'),
store_real_estate_type_cd
OPTIONS(description='The code identifying the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. '),
store_real_estate_type_descr
OPTIONS(description='A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in group language, i.e. in German)'),
open_dt
OPTIONS(description='the date when the store has started its regular operation. (this date may be different from the planned opening date.)'),
planned_open_dt OPTIONS(description='the expected opening date of the store.'), close_dt
OPTIONS(description='the closing date of the store AS set by wawi. (null if the store is open.)'), country_cd
OPTIONS(description='the code according to iso 3166 identifying the country_1, in which the store is located,'),
country_name OPTIONS(description='the name of the country_1, in which the store is located,'), reporting_country_cd
OPTIONS(description='the code according to iso 3166 identifying the country_1, in which the store is located,'),
reporting_country_name OPTIONS(description='the name of the country_1, in which the store is located,'), city_name
OPTIONS(description='the name of the city where the store is located.'), district_name
OPTIONS(description='the name of the district, in which the store is located,'), zip
OPTIONS(description='the postal code of the store address.'), street_name
OPTIONS(description='the name of the street where the store is located.'), house_nr
OPTIONS(description='the number of the building within the street where the store is located.'), lon
OPTIONS(description='the geographical longitude of the store address.'), lat
OPTIONS(description='the geographical latitude of the store address.'), po_box_nr
OPTIONS(description='the post box number of the store. (null if the store does not have post box.)'), phone_nr
OPTIONS(description='the telephone number of the store.'), fax_nr
OPTIONS(description='the telefax number of the store.'), email_addr_txt
OPTIONS(description='an email address_1 for that store.'), sales_mgr_district_sid
OPTIONS(description='the unique identifier (surrogate key) for the organizational unit_1 for which the related sales_1 manager is responsible.'),
sales_mgr_district_nr
OPTIONS(description='the number which identifies the organizational unit_1 for which the related sales_1 manager is responsible.'),
sales_mgr_district_name OPTIONS(description='the name of the related sales_1 manager district.'), sales_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1, who is currently filling the position of the related sales_1 manager.'),
sales_mgr_emp_nr
OPTIONS(description='the employee_1 number of the person who is currently filling the position of the related sales_1 manager.'),
sales_mgr_name
OPTIONS(description='the name of the person who is currently filling the position of the related sales_1 manager.'),
acct_mgr_district_sid
OPTIONS(description='the unique identifier (surrogate key) for the organizational unit_1 for which the related account_1 manager is responsible.'),
acct_mgr_district_nr
OPTIONS(description='the number which identifies the organizational unit_1 for which the related account_1 manager is responsible.'),
acct_mgr_district_name OPTIONS(description='the name of the related account_1 manager district.'), acct_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1, who is currently filling the positon of the related account_1 manager.'),
acct_mgr_emp_nr
OPTIONS(description='the employee_1 number of the person who is currently filling the position of the related account_1 manager.'),
acct_mgr_name
OPTIONS(description='the name of the person who is currently filling the position of the related account_1 manager.'),
sales_company_sid
OPTIONS(description='the unique identifier (surrogate key) for the sales_1 company (vges) to which this store is related.'),
sales_company_nr
OPTIONS(description='the number which identifies the sales_1 company (vges) to which this store is related.'),
sales_company_name OPTIONS(description='the name of the sales_1 company to which this store is related..'),
sales_company_director_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1, who is the director of the related sales_1 company.'),
sales_company_director_emp_nr OPTIONS(description='the employee_1 number of the director of the related sales_1 company.'),
sales_company_director_name OPTIONS(description='the name of the manager of the related sales_1 company.'),
deliv_company_sid OPTIONS(description='surrogate key for the delivery company which is responsible for this store.'),
deliv_company_nr
OPTIONS(description='the number which identifies the delivery company which is responsible for this store.'),
deliv_company_name OPTIONS(description='the name of the delivery company which is responsible for this store..'),
deliv_company_director_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1, who is the director of the related delivery company.'),
deliv_company_director_emp_nr
OPTIONS(description='the employee_1 number of the director of the related delivery company.'), deliv_company_director_name
OPTIONS(description='the name of the manager of the related delivery company.'), expansion_company_sid
OPTIONS(description='the unique identifier (surrogate key) for the expansion company which is responsible for this store.'),
expansion_company_nr
OPTIONS(description='the number which identifies the expansion company which is responsible for this store.'),
expansion_company_name OPTIONS(description='the name of the expansion company which is responsible for this store.'),
bal_sheet_company_sid
OPTIONS(description='the unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..'),
bal_sheet_company_nr
OPTIONS(description='the number which identifies the balance sheet company, which is responsible for this store..'),
bal_sheet_company_name
OPTIONS(description='the name of the balance sheet company, which is responsible for this store..'), owner_company_sid
OPTIONS(description='the unique identifier (surrogate key) for the owner company, which is responsible for this store..'),
owner_company_nr
OPTIONS(description='the number which identifies the owner company, which is responsible for this store..'),
owner_company_name OPTIONS(description='the name of the owner company, which is responsible for this store..'),
country_org_sid OPTIONS(description='the unique identifier (surrogate key) for the related country_1 organization.'),
country_org_cd
OPTIONS(description='the code of the business country_1 for which this country_1 organization is responsible. (the business country_1 is not identical to a political country.)'),
country_org_nr OPTIONS(description='the number which identifies the related country_1 organization.'), country_org_name
OPTIONS(description='the name for the related country_1 organization. (name in group language, i.e. in german). (the country_1 organization is not necessarily identical with a political country_1,)'),
legal_name
OPTIONS(description='the name for the related organizational unit_1 which oversees the business in a group of countries.'),
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
deliv_region_mgr_emp_nr
OPTIONS(description='the employee_1 number of the person who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_name OPTIONS(description='the name of the manager of the related delivery region.'), deliv_region_name
OPTIONS(description='the name of the related delivery region.'), deliv_region_nr
OPTIONS(description='the number which identifies the related delivery region.'), deliv_region_sid
OPTIONS(description='the unique identifier (surrogate key) for the related delivery region_1'), sales_region_mgr_emp_nr
OPTIONS(description='the employee_1 number of the person who is currently filling the role of the manager of the related sales_1 region.'),
sales_region_mgr_emp_sid
OPTIONS(description='the unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related sales_1 region.'),
sales_region_mgr_name OPTIONS(description='the name of the manager of the related sales_1 region.'), sales_region_name
OPTIONS(description='the name of the related sales_1 region.'), sales_region_nr
OPTIONS(description='the number which identifies the related sales_1 region.'), sales_region_sid
OPTIONS(description='the unique identifier (surrogate key) for the related sales_1 region_1'))
OPTIONS(DESCRIPTION = `A STORE, SEEN AS AN INTERNAL ORGANIZATION UNIT_1 OF THE SCHWARZ GROUP. A STORE IS LOCATED AT A PHYSICAL ADDRESS. ITS PURPOSE IS TO OFFER GOODS TO CUSTOMERS. ONLINE-STORES ARE NOT COVERED BY THIS DEFINITION OF A STORE. NOTE THAT THE BUILDING THAT HOUSES THE STORE, IS A RESOURCE ITEM.`)
AS SELECT int_org_sid AS store_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'COUNTRY_1'
  ELSE CAST(int_org_type_cd AS STRING)
  END AS int_org_type_cd,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 curr_int_org_nr AS curr_store_nr,
 init_int_org_nr AS init_store_nr,
 int_org_name AS store_name,
 int_org_status_cd,
 int_org_status_descr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'Country_1'
  WHEN int_org_type_cd = 'STORE'
  THEN store_real_estate_type_cd
  ELSE 'n/a'
  END AS store_real_estate_type_cd,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'Country_1'
  WHEN int_org_type_cd = 'STORE'
  THEN store_real_estate_type_descr
  ELSE 'n/a'
  END AS store_real_estate_type_descr,
 open_dt,
 planned_open_dt,
 close_dt,
 iso_country_cd,
 country_name,
 reporting_country_cd,
 reporting_country_name,
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
  WHEN int_org_sid = acct_mgr_district_sid
  THEN acct_mgr_district_sid
  WHEN int_org_sid = sales_company_sid
  THEN sales_company_sid
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE sales_mgr_district_sid
  END AS sales_mgr_district_sid,
  CASE
  WHEN int_org_sid = acct_mgr_district_sid
  THEN acct_mgr_district_nr
  WHEN int_org_sid = sales_company_sid
  THEN sales_company_nr
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE sales_mgr_district_nr
  END AS sales_mgr_district_nr,
  CASE
  WHEN int_org_sid = acct_mgr_district_sid
  THEN CAST(acct_mgr_district_name AS STRING)
  WHEN int_org_sid = sales_company_sid
  THEN CAST(sales_company_name AS STRING)
  WHEN int_org_sid = sales_region_sid
  THEN CAST(sales_region_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(sales_mgr_district_name AS STRING)
  END AS sales_mgr_district_name,
  CASE
  WHEN int_org_sid = acct_mgr_district_sid
  THEN acct_mgr_emp_sid
  WHEN int_org_sid = sales_company_sid
  THEN sales_mgr_emp_sid
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_emp_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_sid
  ELSE sales_mgr_emp_sid
  END AS sales_mgr_emp_sid,
  CASE
  WHEN int_org_sid = acct_mgr_district_sid
  THEN acct_mgr_emp_nr
  WHEN int_org_sid = sales_company_sid
  THEN sales_mgr_emp_nr
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_mgr_emp_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_mgr_emp_nr
  ELSE sales_mgr_emp_nr
  END AS sales_mgr_emp_nr,
  CASE
  WHEN int_org_sid = acct_mgr_district_sid
  THEN CAST(acct_mgr_name AS STRING)
  WHEN int_org_sid = sales_company_sid
  THEN CAST(sales_mgr_name AS STRING)
  WHEN int_org_sid = sales_region_sid
  THEN CAST(sales_region_mgr_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(sales_mgr_name AS STRING)
  END AS sales_mgr_name,
  CASE
  WHEN int_org_sid = sales_company_sid
  THEN sales_company_sid
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE acct_mgr_district_sid
  END AS acct_mgr_district_sid,
  CASE
  WHEN int_org_sid = sales_company_sid
  THEN sales_company_nr
  WHEN int_org_sid = sales_region_sid
  THEN sales_region_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE acct_mgr_district_nr
  END AS acct_mgr_district_nr,
  CASE
  WHEN int_org_sid = sales_company_sid
  THEN CAST(sales_company_name AS STRING)
  WHEN int_org_sid = sales_region_sid
  THEN CAST(sales_region_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(acct_mgr_district_name AS STRING)
  END AS acct_mgr_district_name,
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
  THEN CAST(sales_mgr_name AS STRING)
  WHEN int_org_sid = sales_region_sid
  THEN CAST(sales_region_mgr_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(acct_mgr_name AS STRING)
  END AS acct_mgr_name,
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
  THEN CAST(sales_region_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(sales_company_name AS STRING)
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
  THEN CAST(sales_region_mgr_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(sales_company_director_name AS STRING)
  END AS sales_company_director_name,
  CASE
  WHEN int_org_sid = deliv_region_sid
  THEN deliv_region_sid
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE deliv_company_sid
  END AS deliv_company_sid,
  CASE
  WHEN int_org_sid = deliv_region_sid
  THEN deliv_region_nr
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE deliv_company_nr
  END AS deliv_company_nr,
  CASE
  WHEN int_org_sid = deliv_region_sid
  THEN CAST(deliv_region_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(deliv_company_name AS STRING)
  END AS deliv_company_name,
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
  THEN CAST(deliv_region_mgr_name AS STRING)
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(deliv_company_director_name AS STRING)
  END AS deliv_company_director_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE expansion_company_sid
  END AS expansion_company_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE expansion_company_nr
  END AS expansion_company_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(expansion_company_name AS STRING)
  END AS expansion_company_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE bal_sheet_company_sid
  END AS bal_sheet_company_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE bal_sheet_company_nr
  END AS bal_sheet_company_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(bal_sheet_company_name AS STRING)
  END AS bal_sheet_company_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_sid
  ELSE owner_company_sid
  END AS owner_company_sid,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN country_org_nr
  ELSE owner_company_nr
  END AS owner_company_nr,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(owner_company_name AS STRING)
  END AS owner_company_name,
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
  THEN 'Unbekannt'
  ELSE CAST(deliv_region_name AS STRING)
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
  END AS deliv_region_sid,
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
  THEN 'Unbekannt'
  ELSE CAST(sales_region_mgr_name AS STRING)
  END AS sales_region_mgr_name,
  CASE
  WHEN int_org_sid = country_org_sid
  THEN 'Unbekannt'
  ELSE CAST(sales_region_name AS STRING)
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
 AND int_org_type_cd NOT IN ('COUNTRY_GRP', 'TRUST')
 AND int_org_status_cd NOT IN ('PRE-PROCESS');