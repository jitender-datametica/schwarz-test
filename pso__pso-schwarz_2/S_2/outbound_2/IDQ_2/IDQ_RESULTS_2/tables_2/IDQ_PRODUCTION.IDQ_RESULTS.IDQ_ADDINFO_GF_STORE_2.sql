CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_gf_store_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(100),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
store_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a store.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
curr_store_nr STRING(20) NOT NULL
OPTIONS(description='The number by which the store is currently known to business. The store number is identical to the real estate number of the object which currently houses the store. In case the building changes, the store_sid remains unchanged, but the store number gets updated.'),
init_store_nr STRING(20) NOT NULL
OPTIONS(description='The initial store number, i.e. the number which was assigned to the store before the first relocation or demolition. This number does not change, in case the building changes.'),
store_name STRING(100) NOT NULL OPTIONS(description='The name of the store.'),
int_org_status_cd STRING(20) NOT NULL
OPTIONS(description='The code for the retail status_2 of a store. The status_2 codes for <open> and <closed> are strictly connected with the store open date and the store close date, as they are derived from these attributes.'),
int_org_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the retail status_2 (open / closed) of a store in group language, i.e. in German.'),
real_estate_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
open_dt DATE
OPTIONS(description='The date when the store has started its regular operation. (This date may be different from the planned opening date.)'),
planned_open_dt DATE OPTIONS(description='The expected opening date of the store.'),
close_dt DATE OPTIONS(description='The closing date of the store as set by WAWI. (NULL if the store is open.)'),
iso_country_cd STRING(2) NOT NULL
OPTIONS(description='The code according to ISO 3166 identifying the country_2, in which the store is located,'),
country_name STRING(100) NOT NULL OPTIONS(description='The name of the country_2, in which the store is located,'),
city_name STRING(100) OPTIONS(description='The name of the city where the store is located.'),
district_name STRING(100) OPTIONS(description='The name of the district, in which the store is located,'),
zip STRING(15) OPTIONS(description='The postal code of the store address.'),
street_name STRING(100) OPTIONS(description='The name of the street where the store is located.'),
house_nr STRING(100) OPTIONS(description='The number of the building within the street where the store is located.'),
lon NUMERIC(9,6) OPTIONS(description='The geographical longitude of the store address.'),
lat NUMERIC(9,6) OPTIONS(description='The geographical latitude of the store address.'),
po_box_nr STRING(20)
OPTIONS(description='The post box number of the store. (NULL if the store does not have post box.)'),
phone_nr STRING(100) OPTIONS(description='The telephone number of the store.'),
fax_nr STRING(100) OPTIONS(description='The telefax number of the store.'),
email_addr_txt STRING(1000) OPTIONS(description='An email address_2 for that store.'),
sales_mgr_district_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit_2 for which the related sales_2 manager is responsible.'),
sales_mgr_district_nr STRING(20)
OPTIONS(description='The number which identifies the organizational unit_2 for which the related sales_2 manager is responsible.'),
sales_mgr_district_name STRING(100) NOT NULL OPTIONS(description='The name of the related sales_2 manager district.'),
sales_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who is currently filling the position of the related sales_2 manager.'),
sales_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the person who is currently filling the position of the related sales_2 manager.'),
sales_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the person who is currently filling the position of the related sales_2 manager.'),
acct_mgr_district_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit_2 for which the related account_2 manager is responsible.'),
acct_mgr_district_nr STRING(20)
OPTIONS(description='The number which identifies the organizational unit_2 for which the related account_2 manager is responsible.'),
acct_mgr_district_name STRING(100) NOT NULL OPTIONS(description='The name of the related account_2 manager district.'),
acct_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who is currently filling the positon of the related account_2 manager.'),
acct_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the person who is currently filling the position of the related account_2 manager.'),
acct_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the person who is currently filling the position of the related account_2 manager.'),
sales_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales_2 company (VGES) to which this store is related.'),
sales_company_nr STRING(20)
OPTIONS(description='The number which identifies the sales_2 company (VGES) to which this store is related.'),
sales_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the sales_2 company to which this store is related..'),
sales_company_director_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who is the director of the related sales_2 company.'),
sales_company_director_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the director of the related sales_2 company.'),
sales_company_director_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager of the related sales_2 company.'),
deliv_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key for the delivery company which is responsible for this store.'),
deliv_company_nr STRING(20)
OPTIONS(description='The number which identifies the delivery company which is responsible for this store.'),
deliv_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the delivery company which is responsible for this store..'),
deliv_company_director_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2, who is the director of the related delivery company.'),
deliv_company_director_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the director of the related delivery company.'),
deliv_company_director_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager of the related delivery company.'),
expansion_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the expansion company which is responsible for this store.'),
expansion_company_nr STRING(20)
OPTIONS(description='The number which identifies the expansion company which is responsible for this store.'),
expansion_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the expansion company which is responsible for this store.'),
bal_sheet_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the balance sheet company, which is responsible for this store..'),
bal_sheet_company_nr STRING(20)
OPTIONS(description='The number which identifies the balance sheet company, which is responsible for this store..'),
bal_sheet_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the balance sheet company, which is responsible for this store..'),
owner_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the owner company, which is responsible for this store..'),
owner_company_nr STRING(20)
OPTIONS(description='The number which identifies the owner company, which is responsible for this store..'),
owner_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the owner company, which is responsible for this store..'),
org_region_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related organizational region_2'),
org_region_nr STRING(20) OPTIONS(description='The number which identifies the related organizational region.'),
org_region_name STRING(100) NOT NULL OPTIONS(description='The name of the related organizational region.'),
org_region_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who is currently filling the role of the manager of the related organizational region.'),
org_region_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the person who is currently filling the role of the manager of the related organizational region.'),
org_region_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager of the related organizational region.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd STRING(2)
OPTIONS(description='The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)'),
country_org_nr STRING(20) OPTIONS(description='The number which identifies the related country_2 organization.'),
country_org_name STRING(100) NOT NULL
OPTIONS(description='The name for the related country_2 organization. (name in group language, i.e. in German). (The country_2 organization is not necessarily identical with a political country_2)'),
country_org_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who is responsible for the related country_2 organization.'),
country_org_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the manager who is responsible for the related country_2 organization.'),
country_org_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager who is responsible for the related country_2 organization.'),
country_grp_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_nr STRING(20)
OPTIONS(description='The number which identifies the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_name STRING(100) NOT NULL
OPTIONS(description='The name for the related organizational unit_2 which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_2 who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_2 number of the manager who is responsible for the related group of countries.'),
country_grp_org_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager who is responsible for the related group of countries.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (store_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A store, seen as an internal organization unit_2 of the Schwarz Group. A store is located at a physical address. Its purpose is to offer goods to customers. Online-stores are not covered by this definition of a store. Note that the building that houses the store, is a resource item.');