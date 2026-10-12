CREATE OR REPLACE VIEW fe_mstr_master.v_dim_store_hist (store_sid
OPTIONS(description='The unique identifier (surrogate key) for a store.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
curr_store_nr
OPTIONS(description='The number by which the store is currently known to business. The store number is identical to the real estate number of the object which currently houses the store. In case the building changes, the store_sid remains unchanged, but the store number gets updated.'),
init_store_nr
OPTIONS(description='The initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. This number does not change, in case the building changes.'),
store_name OPTIONS(description='The name of the store.'), int_org_status_cd
OPTIONS(description='The code for the retail status of a store. The status codes for <open> and <closed> are strictly connected with the store open date and the store close date, as they are derived from these attributes.'),
int_org_status_descr
OPTIONS(description='A textual description for the retail status (open / closed) of a store in group language, i.e. in German.'),
open_dt
OPTIONS(description='The date when the store has started its regular operation. (This date may be different from the planned opening date.)'),
planned_open_dt OPTIONS(description='The expected opening date of the store.'), close_dt
OPTIONS(description='The closing date of the store as set by WAWI. (NULL if the store is open.)'), iso_country_cd
OPTIONS(description='The code according to ISO 3166 identifying the country, in which the store is located,'),
country_name OPTIONS(description='The name of the country, in which the store is located,'), city_name
OPTIONS(description='The name of the city where the store is located.'), district_name
OPTIONS(description='The name of the district, in which the store is located,'), zip
OPTIONS(description='The postal code of the store address.'), street_name
OPTIONS(description='The name of the street where the store is located.'), house_nr
OPTIONS(description='The number of the building within the street where the store is located.'), lon
OPTIONS(description='The geographical longitude of the store address.'), lat
OPTIONS(description='The geographical latitude of the store address.'), po_box_nr
OPTIONS(description='The post box number of the store. (NULL if the store does not have post box.)'), phone_nr
OPTIONS(description='The telephone number of the store.'), fax_nr
OPTIONS(description='The telefax number of the store.'), email_addr_txt
OPTIONS(description='An email address for that store.'), reporting_country_cd
OPTIONS(description='The code which identifies the reporting country in which the store is located.'),
reporting_country_name
OPTIONS(description='The name the reporting country. (i.e. a country definition which is different from a geographical country) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'),
sales_mgr_district_sid
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit for which the related sales manager is responsible.'),
sales_mgr_district_nr
OPTIONS(description='The number which identifies the organizational unit for which the related sales manager is responsible.'),
sales_mgr_district_name OPTIONS(description='The name of the related sales manager district.'), sales_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee, who is currently filling the position of the related sales manager.'),
sales_mgr_emp_nr
OPTIONS(description='The employee number of the person who is currently filling the position of the related sales manager.'),
sales_mgr_name
OPTIONS(description='The name of the person who is currently filling the position of the related sales manager.'),
acct_mgr_district_sid
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit for which the related account manager is responsible.'),
acct_mgr_district_nr
OPTIONS(description='The number which identifies the organizational unit for which the related account manager is responsible.'),
acct_mgr_district_name OPTIONS(description='The name of the related account manager district.'), acct_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee, who is currently filling the positon of the related account manager.'),
acct_mgr_emp_nr
OPTIONS(description='The employee number of the person who is currently filling the position of the related account manager.'),
acct_mgr_name
OPTIONS(description='The name of the person who is currently filling the position of the related account manager.'),
sales_company_sid
OPTIONS(description='The unique identifier (surrogate key) for the sales company (VGES) to which this store is related.'),
sales_company_nr
OPTIONS(description='The number which identifies the sales company (VGES) to which this store is related.'),
sales_company_name OPTIONS(description='The name of the sales company to which this store is related..'),
sales_company_director_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee, who is the director of the related sales company.'),
sales_company_director_emp_nr OPTIONS(description='The employee number of the director of the related sales company.'),
sales_company_director_name OPTIONS(description='The name of the manager of the related sales company.'),
deliv_company_sid OPTIONS(description='Surrogate key for the delivery company which is responsible for this store.'),
deliv_company_nr
OPTIONS(description='The number which identifies the delivery company which is responsible for this store.'),
deliv_company_name OPTIONS(description='The name of the delivery company which is responsible for this store..'),
deliv_company_director_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee, who is the director of the related delivery company.'),
deliv_company_director_emp_nr
OPTIONS(description='The employee number of the director of the related delivery company.'), deliv_company_director_name
OPTIONS(description='The name of the manager of the related delivery company.'), expansion_company_sid
OPTIONS(description='The unique identifier (surrogate key) for the expansion company which is responsible for this store.'),
expansion_company_nr
OPTIONS(description='The number which identifies the expansion company which is responsible for this store.'),
expansion_company_name OPTIONS(description='The name of the expansion company which is responsible for this store.'),
bal_sheet_company_sid
OPTIONS(description='The unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..'),
bal_sheet_company_nr
OPTIONS(description='The number which identifies the balance sheet company, which is responsible for this store..'),
bal_sheet_company_name
OPTIONS(description='The name of the balance sheet company, which is responsible for this store..'), owner_company_sid
OPTIONS(description='The unique identifier (surrogate key) for the owner company, which is responsible for this store..'),
owner_company_nr
OPTIONS(description='The number which identifies the owner company, which is responsible for this store..'),
owner_company_name OPTIONS(description='The name of the owner company, which is responsible for this store..'),
sales_region_sid OPTIONS(description='The unique identifier (surrogate key) for the related sales region'),
sales_region_nr OPTIONS(description='The number which identifies the related sales region.'), sales_region_name
OPTIONS(description='The name of the related sales region.'), sales_region_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee who is currently filling the role of the manager of the related sales region.'),
sales_region_mgr_emp_nr
OPTIONS(description='The employee number of the person who is currently filling the role of the manager of the related sales region.'),
sales_region_mgr_name OPTIONS(description='The name of the manager of the related sales region.'), deliv_region_sid
OPTIONS(description='The unique identifier (surrogate key) for the related delivery region'), deliv_region_nr
OPTIONS(description='The number which identifies the related delivery region.'), deliv_region_name
OPTIONS(description='The name of the related delivery region.'), deliv_region_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_emp_nr
OPTIONS(description='The employee number of the person who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_name OPTIONS(description='The name of the manager of the related delivery region.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the related country organization.'), country_org_cd
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
country_org_nr OPTIONS(description='The number which identifies the related country organization.'), country_org_name
OPTIONS(description='The name for the related country organization. (name in group language, i.e. in German). (The country organization is not necessarily identical with a political country)'),
country_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee who is responsible for the related country organization.'),
country_org_mgr_emp_nr
OPTIONS(description='The employee number of the manager who is responsible for the related country organization.'),
country_org_mgr_name
OPTIONS(description='The name of the manager who is responsible for the related country organization.'),
country_grp_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the related organizational unit which oversees the business in a group of countries.'),
country_grp_org_nr
OPTIONS(description='The number which identifies the related organizational unit which oversees the business in a group of countries.'),
country_grp_org_name
OPTIONS(description='The name for the related organizational unit which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr
OPTIONS(description='The employee number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name
OPTIONS(description='The name of the manager who is responsible for the related group of countries.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A STORE, SEEN AS AN INTERNAL ORGANIZATION UNIT OF THE SCHWARZ GROUP. A STORE IS LOCATED AT A PHYSICAL ADDRESS. ITS PURPOSE IS TO OFFER GOODS TO CUSTOMERS. ONLINE-STORES ARE NOT COVERED BY THIS DEFINITION OF A STORE. NOTE THAT THE BUILDING THAT HOUSES THE STORE, IS A RESOURCE ITEM.`)
AS SELECT int_org_sid AS store_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 curr_int_org_nr AS curr_store_nr,
 init_int_org_nr AS init_store_nr,
 int_org_name AS store_name,
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
 reporting_country_cd,
 reporting_country_name,
 sales_mgr_district_sid,
 sales_mgr_district_nr,
 sales_mgr_district_name,
 sales_mgr_emp_sid,
 sales_mgr_emp_nr,
 sales_mgr_name,
 acct_mgr_district_sid,
 acct_mgr_district_nr,
 acct_mgr_district_name,
 acct_mgr_emp_sid,
 acct_mgr_emp_nr,
 acct_mgr_name,
 sales_company_sid,
 sales_company_nr,
 sales_company_name,
 sales_company_director_emp_sid,
 sales_company_director_emp_nr,
 sales_company_director_name,
 deliv_company_sid,
 deliv_company_nr,
 deliv_company_name,
 deliv_company_director_emp_sid,
 deliv_company_director_emp_nr,
 deliv_company_director_name,
 expansion_company_sid,
 expansion_company_nr,
 expansion_company_name,
 bal_sheet_company_sid,
 bal_sheet_company_nr,
 bal_sheet_company_name,
 owner_company_sid,
 owner_company_nr,
 owner_company_name,
 sales_region_sid,
 sales_region_nr,
 sales_region_name,
 sales_region_mgr_emp_sid,
 sales_region_mgr_emp_nr,
 sales_region_mgr_name,
 deliv_region_sid,
 deliv_region_nr,
 deliv_region_name,
 deliv_region_mgr_emp_sid,
 deliv_region_mgr_emp_nr,
 deliv_region_mgr_name,
 country_org_sid,
 country_org_cd,
 country_org_nr,
 country_org_name,
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
 dwh_node_cd
FROM ldl_data_core_dim.t_dim_internal_organization AS MAIN
WHERE int_org_type_cd = 'STORE';