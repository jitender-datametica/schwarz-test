CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_STORE_HIST (
store_sid COMMENT 'The unique identifier (surrogate key) for a store.'
,dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.'
,dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.'
,dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'
,curr_store_nr COMMENT 'The number by which the store is currently known to business. The store number is identical to the real estate number of the object which currently houses the store. In case the building changes, the store_sid remains unchanged, but the store number gets updated.'
,init_store_nr COMMENT 'The initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. This number does not change, in case the building changes.'
,store_name COMMENT 'The name of the store.'
,int_org_status_cd COMMENT 'The code for the retail status of a store. The status codes for <open> and <closed> are strictly connected with the store open date and the store close date, as they are derived from these attributes.'
,int_org_status_descr COMMENT 'A textual description for the retail status (open / closed) of a store in group language, i.e. in German.'
,open_dt COMMENT 'The date when the store has started its regular operation. (This date may be different from the planned opening date.)'
,planned_open_dt COMMENT 'The expected opening date of the store.'
,close_dt COMMENT 'The closing date of the store as set by WAWI. (NULL if the store is open.)'
,iso_country_cd COMMENT 'The code according to ISO 3166 identifying the country, in which the store is located,'
,country_name COMMENT 'The name of the country, in which the store is located,'
,city_name COMMENT 'The name of the city where the store is located.'
,district_name COMMENT 'The name of the district, in which the store is located,'
,zip COMMENT 'The postal code of the store address.'
,street_name COMMENT 'The name of the street where the store is located.'
,house_nr COMMENT 'The number of the building within the street where the store is located.'
,lon COMMENT 'The geographical longitude of the store address.'
,lat COMMENT 'The geographical latitude of the store address.'
,po_box_nr COMMENT 'The post box number of the store. (NULL if the store does not have post box.)'
,phone_nr COMMENT 'The telephone number of the store.'
,fax_nr COMMENT 'The telefax number of the store.'
,email_addr_txt COMMENT 'An email address for that store.'
,reporting_country_cd COMMENT 'The code which identifies the reporting country in which the store is located.'
,reporting_country_name COMMENT 'The name the reporting country. (i.e. a country definition which is different from a geographical country) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'
,sales_mgr_district_sid COMMENT 'The unique identifier (surrogate key) for the organizational unit for which the related sales manager is responsible.'
,sales_mgr_district_nr COMMENT 'The number which identifies the organizational unit for which the related sales manager is responsible.'
,sales_mgr_district_name COMMENT 'The name of the related sales manager district.'
,sales_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee, who is currently filling the position of the related sales manager.'
,sales_mgr_emp_nr COMMENT 'The employee number of the person who is currently filling the position of the related sales manager.'
,sales_mgr_name COMMENT 'The name of the person who is currently filling the position of the related sales manager.'
,acct_mgr_district_sid COMMENT 'The unique identifier (surrogate key) for the organizational unit for which the related account manager is responsible.'
,acct_mgr_district_nr COMMENT 'The number which identifies the organizational unit for which the related account manager is responsible.'
,acct_mgr_district_name COMMENT 'The name of the related account manager district.'
,acct_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee, who is currently filling the positon of the related account manager.'
,acct_mgr_emp_nr COMMENT 'The employee number of the person who is currently filling the position of the related account manager.'
,acct_mgr_name COMMENT 'The name of the person who is currently filling the position of the related account manager.'
,sales_company_sid COMMENT 'The unique identifier (surrogate key) for the sales company (VGES) to which this store is related.'
,sales_company_nr COMMENT 'The number which identifies the sales company (VGES) to which this store is related.'
,sales_company_name COMMENT 'The name of the sales company to which this store is related..'
,sales_company_director_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee, who is the director of the related sales company.'
,sales_company_director_emp_nr COMMENT 'The employee number of the director of the related sales company.'
,sales_company_director_name COMMENT 'The name of the manager of the related sales company.'
,deliv_company_sid COMMENT 'Surrogate key for the delivery company which is responsible for this store.'
,deliv_company_nr COMMENT 'The number which identifies the delivery company which is responsible for this store.'
,deliv_company_name COMMENT 'The name of the delivery company which is responsible for this store..'
,deliv_company_director_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee, who is the director of the related delivery company.'
,deliv_company_director_emp_nr COMMENT 'The employee number of the director of the related delivery company.'
,deliv_company_director_name COMMENT 'The name of the manager of the related delivery company.'
,expansion_company_sid COMMENT 'The unique identifier (surrogate key) for the expansion company which is responsible for this store.'
,expansion_company_nr COMMENT 'The number which identifies the expansion company which is responsible for this store.'
,expansion_company_name COMMENT 'The name of the expansion company which is responsible for this store.'
,bal_sheet_company_sid COMMENT 'The unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..'
,bal_sheet_company_nr COMMENT 'The number which identifies the balance sheet company, which is responsible for this store..'
,bal_sheet_company_name COMMENT 'The name of the balance sheet company, which is responsible for this store..'
,owner_company_sid COMMENT 'The unique identifier (surrogate key) for the owner company, which is responsible for this store..'
,owner_company_nr COMMENT 'The number which identifies the owner company, which is responsible for this store..'
,owner_company_name COMMENT 'The name of the owner company, which is responsible for this store..'
,sales_region_sid COMMENT 'The unique identifier (surrogate key) for the related sales region'
,sales_region_nr COMMENT 'The number which identifies the related sales region.'
,sales_region_name COMMENT 'The name of the related sales region.'
,sales_region_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee who is currently filling the role of the manager of the related sales region.'
,sales_region_mgr_emp_nr COMMENT 'The employee number of the person who is currently filling the role of the manager of the related sales region.'
,sales_region_mgr_name COMMENT 'The name of the manager of the related sales region.'
,deliv_region_sid COMMENT 'The unique identifier (surrogate key) for the related delivery region'
,deliv_region_nr COMMENT 'The number which identifies the related delivery region.'
,deliv_region_name COMMENT 'The name of the related delivery region.'
,deliv_region_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee who is currently filling the role of the manager of the related delivery region.'
,deliv_region_mgr_emp_nr COMMENT 'The employee number of the person who is currently filling the role of the manager of the related delivery region.'
,deliv_region_mgr_name COMMENT 'The name of the manager of the related delivery region.'
,country_org_sid COMMENT 'The unique identifier (surrogate key) for the related country organization.'
,country_org_cd COMMENT 'The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'
,country_org_nr COMMENT 'The number which identifies the related country organization.'
,country_org_name COMMENT 'The name for the related country organization. (name in group language, i.e. in German). (The country organization is not necessarily identical with a political country,)'
,country_org_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee who is responsible for the related country organization.'
,country_org_mgr_emp_nr COMMENT 'The employee number of the manager who is responsible for the related country organization.'
,country_org_mgr_name COMMENT 'The name of the manager who is responsible for the related country organization.'
,country_grp_org_sid COMMENT 'The unique identifier (surrogate key) for the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_nr COMMENT 'The number which identifies the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_name COMMENT 'The name for the related organizational unit which oversees the business in a group of countries.'
,country_grp_org_mgr_emp_sid COMMENT 'The unique identifier (surrogate key) for the employee who is responsible for the related group of countries.'
,country_grp_org_mgr_emp_nr COMMENT 'The employee number of the manager who is responsible for the related group of countries.'
,country_grp_org_mgr_name COMMENT 'The name of the manager who is responsible for the related group of countries.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'A store, seen as an internal organization unit of the Schwarz Group. A store is located at a physical address. Its purpose is to offer goods to customers. Online-stores are not covered by this definition of a store. Note that the building that houses the store, is a resource item.' AS SELECT
main.int_org_sid AS store_sid
,main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
,main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
,main.dwh_valid_fg AS dwh_valid_fg
,main.curr_int_org_nr AS curr_store_nr
,main.init_int_org_nr AS init_store_nr
,main.int_org_name AS store_name
,main.int_org_status_cd AS int_org_status_cd
,main.int_org_status_descr AS int_org_status_descr
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
,main.reporting_country_cd AS reporting_country_cd
,main.reporting_country_name AS reporting_country_name
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
,main.deliv_company_sid AS deliv_company_sid
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
,main.sales_region_sid AS sales_region_sid
,main.sales_region_nr AS sales_region_nr
,main.sales_region_name AS sales_region_name
,main.sales_region_mgr_emp_sid AS sales_region_mgr_emp_sid
,main.sales_region_mgr_emp_nr AS sales_region_mgr_emp_nr
,main.sales_region_mgr_name AS sales_region_mgr_name
,main.deliv_region_sid AS deliv_region_sid
,main.deliv_region_nr AS deliv_region_nr
,main.deliv_region_name AS deliv_region_name
,main.deliv_region_mgr_emp_sid AS deliv_region_mgr_emp_sid
,main.deliv_region_mgr_emp_nr AS deliv_region_mgr_emp_nr
,main.deliv_region_mgr_name AS deliv_region_mgr_name
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
FROM CORE_DIM.T_DIM_INTERNAL_ORGANIZATION main
WHERE main.int_org_type_cd = 'STORE';