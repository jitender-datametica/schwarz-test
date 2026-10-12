/* --------------------------------------------------------------------------------
   DDL for table: t_dim_internal_organization_1
   generated from Powerdesigner on Dienstag, 28. Mai 2024 20:46:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_dim_internal_organization_1 (
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
int_org_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for internal organizations. (Description in group language, i.e. in German)'),
curr_int_org_nr STRING(20) NOT NULL
OPTIONS(description='The number by which the internal organization is currently known to business. (This number may change over time)'),
init_int_org_nr STRING(20) NOT NULL OPTIONS(description='The initial number for the internal organization,'),
int_org_name STRING(100) NOT NULL OPTIONS(description='The name of the internal organization.'),
int_org_short_name STRING(100)
OPTIONS(description='In case of internal companies, this column is filled with a three-letter abbreviation which identifies the internal company. E.g. LAA for Laakirchen.'),
legal_name STRING(100)
OPTIONS(description='In case the internal organization is an legal entity, this is its official name, as shown in the company register.'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='The code according to ISO-4217, identifying the currency which is used in this internal organization.'),
int_org_status_cd STRING(20) NOT NULL
OPTIONS(description='The code for the lifecycle status_1 of an internal organization.'),
int_org_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_1 of an internal organization. (Description in group language, i.e. in German)'),
store_real_estate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. '),
store_real_estate_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of buildings which are used by a store. A store may operate in a regular building (store building), in a special purpose store building or in both. (Description in group language, i.e. in German)'),
open_dt DATE
OPTIONS(description='The date when the internal organization has started its regular operation. (This date may be different from the planned opening date.)'),
planned_open_dt DATE OPTIONS(description='The expected opening date of the internal organization.'),
close_dt DATE OPTIONS(description='The closing date of the internal organization.'),
comp_period_start_dt DATE
OPTIONS(description='The start date of the period in which the revenue of the store can be compared with the corresponding revenue in the previous year. When comparing the revenue, the growth that is caused purely by the increase in  the number of stores, shall be excluded. (bereinigte Steigerung) So the first year after the opening of the store needs to be excluded. The period in which revenue may be compared, starts on the first Monday after the corresponding day one year after the opening of the store, and it ends on the Sunday after the closing of the store.'),
comp_period_end_dt DATE
OPTIONS(description='The start date of the period in which the revenue of the store can be compared with the corresponding revenue in the previous year. When comparing the revenue, the growth that is caused purely by the increase in  the number of stores, shall be excluded. (bereinigte Steigerung) So the first year after the opening of the store needs to be excluded. The period in which revenue may be compared, starts on the first Monday after the corresponding day one year after the opening of the store, and it ends on the Sunday after the closing of the store.'),
iso_country_cd STRING(2) NOT NULL
OPTIONS(description='The code according to ISO 3166 identifying the country_1, in which the internal organization is located,'),
country_name STRING(100) NOT NULL
OPTIONS(description='The name of the country_1, in which the internal organization is located, (Name in group language, i.e. German)'),
city_name STRING(100) OPTIONS(description='The name of the city where the internal organization is located.'),
district_name STRING(100)
OPTIONS(description='The name of the district, in which the internal organization is located,'),
zip STRING(15) OPTIONS(description='The postal code of the address_1 of the internal organization.'),
street_name STRING(100) OPTIONS(description='The name of the street where the internal organization is located.'),
house_nr STRING(100)
OPTIONS(description='The number of the building within the street where the internal organization is located.'),
lon NUMERIC(9,6) OPTIONS(description='The geographical longitude of the address_1 of the internal organization.'),
lat NUMERIC(9,6) OPTIONS(description='The geographical latitude of the address_1 of the internal organization.'),
po_box_nr STRING(20)
OPTIONS(description='The post box number of the internal organization. (NULL if the internal organization does not have post box.)'),
phone_nr STRING(100) OPTIONS(description='The telephone number of the internal organization.'),
fax_nr STRING(100) OPTIONS(description='The telefax number of the internal organization.'),
email_addr_txt STRING(1000) OPTIONS(description='An email address_1 for that internal organization.'),
reporting_country_cd STRING(20) NOT NULL
OPTIONS(description='The code which identifies the reporting country_1 in which the internal organization is located.'),
reporting_country_name STRING(100) NOT NULL
OPTIONS(description='The name the reporting country. (i.e. a country_1 definition which is different from a geographical country_1) The name in in group lanuage, i.e. in German. (Name in group language, i.e. in German)'),
official_lang_cd STRING(2) OPTIONS(description='Code of the official language that is used withing the organization'),
is_sales_company_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as a sales_1 company.'),
is_deliv_company_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as a delivery company.'),
is_country_org_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as a country_1 organization.'),
is_expansion_company_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as an expansion company.'),
is_bal_sheet_company_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as a balance sheet company.'),
is_owner_company_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as an owner company.'),
is_trust_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the internal organization is an internal company acting as the trust (Stiftung).'),
sales_mgr_district_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit_1 for which the related sales_1 manager is responsible.'),
sales_mgr_district_nr STRING(20)
OPTIONS(description='The number which identifies the organizational unit_1 for which the related sales_1 manager is responsible.'),
sales_mgr_district_name STRING(100) NOT NULL OPTIONS(description='The name of the related sales_1 manager district.'),
sales_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1, who is currently filling the position of the related sales_1 manager.'),
sales_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the person who is currently filling the position of the related sales_1 manager.'),
sales_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the person who is currently filling the position of the related sales_1 manager.'),
acct_mgr_district_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the organizational unit_1 for which the related account_1 manager is responsible.'),
acct_mgr_district_nr STRING(20)
OPTIONS(description='The number which identifies the organizational unit_1 for which the related account_1 manager is responsible.'),
acct_mgr_district_name STRING(100) NOT NULL OPTIONS(description='The name of the related account_1 manager district.'),
acct_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1, who is currently filling the position of the related account_1 manager.'),
acct_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the person who is currently filling the position of the related account_1 manager.'),
acct_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the person who is currently filling the position of the related account_1 manager.'),
sales_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sales_1 company (VGES) to which this internal organization is related.'),
sales_company_nr STRING(20)
OPTIONS(description='The number which identifies the sales_1 company (VGES) to which this internal organization is related.'),
sales_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the sales_1 company to which this internal organization is related..'),
sales_company_director_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1, who is the director of the related sales_1 company.'),
sales_company_director_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the director of the related sales_1 company.'),
sales_company_director_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager of the related sales_1 company.'),
deliv_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key for the delivery company which is responsible for this internal organization.'),
deliv_company_nr STRING(20)
OPTIONS(description='The number which identifies the delivery company which is responsible for this internal organization.'),
deliv_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the delivery company which is responsible for this internal organization.'),
deliv_company_director_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1, who is the director of the related delivery company.'),
deliv_company_director_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the director of the related delivery company.'),
deliv_company_director_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager of the related delivery company.'),
expansion_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the expansion company which is responsible for this internal organization.'),
expansion_company_nr STRING(20)
OPTIONS(description='The number which identifies the expansion company which is responsible for this internal organization.'),
expansion_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the expansion company which is responsible for this internal organization.'),
bal_sheet_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the balance sheet company, which is responsible for this internal organization.'),
bal_sheet_company_nr STRING(20)
OPTIONS(description='The number which identifies the balance sheet company, which is responsible for this internal organization.'),
bal_sheet_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the balance sheet company, which is responsible for this internal organization.'),
owner_company_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the owner company, which is responsible for this internal organization.'),
owner_company_nr STRING(20)
OPTIONS(description='The number which identifies the owner company, which is responsible for this internal organization.'),
owner_company_name STRING(100) NOT NULL
OPTIONS(description='The name of the owner company, which is responsible for this internal organization.'),
sales_region_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related sales_1 region_1'),
sales_region_nr STRING(20) OPTIONS(description='The number which identifies the related sales_1 region.'),
sales_region_name STRING(100) NOT NULL OPTIONS(description='The name of the related sales_1 region.'),
sales_region_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related sales_1 region.'),
sales_region_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the person who is currently filling the role of the manager of the related sales_1 region.'),
sales_region_mgr_name STRING(100) NOT NULL OPTIONS(description='The name of the manager of the related sales_1 region.'),
deliv_region_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related delivery region_1'),
deliv_region_nr STRING(20) OPTIONS(description='The number which identifies the related delivery region.'),
deliv_region_name STRING(100) NOT NULL OPTIONS(description='The name of the related delivery region.'),
deliv_region_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the person who is currently filling the role of the manager of the related delivery region.'),
deliv_region_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager of the related delivery region.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_1 organization.'),
country_org_cd STRING(2)
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
country_org_nr STRING(20) OPTIONS(description='The number which identifies the related country_1 organization.'),
country_org_name STRING(100) NOT NULL
OPTIONS(description='The name for the related country_1 organization. The country_1 organization is not necessarily identical with a political country_1, (Name in group language, i.e. in German). '),
country_org_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is responsible for the related country_1 organization.'),
country_org_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the manager who is responsible for the related country_1 organization.'),
country_org_mgr_name STRING(100) NOT NULL
OPTIONS(description='The name of the manager who is responsible for the related country_1 organization.'),
country_grp_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_nr STRING(20)
OPTIONS(description='The number which identifies the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_name STRING(100) NOT NULL
OPTIONS(description='The name for the related organizational unit_1 which oversees the business in a group of countries.'),
country_grp_org_mgr_emp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employee_1 who is responsible for the related group of countries.'),
country_grp_org_mgr_emp_nr STRING(20)
OPTIONS(description='The employee_1 number of the manager who is responsible for the related group of countries.'),
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
PRIMARY KEY (int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This dimensions contains organizational units of the Schwarz Group, irrespective of their type.');