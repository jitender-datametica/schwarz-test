CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_internal_organization (
int_org_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
int_org_nr STRING(20) NOT NULL
OPTIONS(description='The number by which the internal organization is identified by business.'),
int_org_name STRING(100) OPTIONS(description='The name by which the internal organization is known.'),
open_dt DATE
OPTIONS(description='The date when the internal organization unit (store, warehouse, …) has started its regular operation. (This date may be different from the planned opening date.)'),
planned_open_dt DATE
OPTIONS(description='The date for which it was initially intended that the internal organization unit (store, warehouse, …) starts its regular operation. (This date may be different from the actual opening date.)'),
close_dt DATE
OPTIONS(description='The date when the internal organization unit (store, warehouse, …) has stopped its regular operation.'),
curr_cd STRING(3) OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
holiday_store_fg BOOL OPTIONS(description='An indicator showing, if the store is open on public holidays.'),
legal_name STRING(100) OPTIONS(description='The official name of the company, as shown in the company register.'),
vat_nr STRING(20) OPTIONS(description='The VAT identification number of the company.'),
country_org_cd STRING(2)
OPTIONS(description='The code of the business country for which this country organization is responsible. (The business country is not identical to a political country.)'),
comment_txt STRING(1000) OPTIONS(description='A free text comment to the internal organization'),
is_sales_company_fg BOOL OPTIONS(description='An indicator showing, if the internal company is a sales company.'),
is_deliv_company_fg BOOL OPTIONS(description='An indicator showing, if the internal company is a delivery company.'),
is_country_org_fg BOOL OPTIONS(description='An indicator showing, if the internal company is a country organization.'),
is_expansion_company_fg BOOL
OPTIONS(description='An indicator showing, if the internal company is an expansion company.'),
is_bal_sheet_company_fg BOOL
OPTIONS(description='An indicator showing, if the internal company is a balance sheet company.'),
is_owner_company_fg BOOL OPTIONS(description='An indicator showing, if the internal company is an owner company.'),
is_trust_fg BOOL OPTIONS(description='An indicator showing, if the internal company is the trust (Stiftung).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
int_org_short_name STRING(100)
OPTIONS(description='In case of internal companies, this column is filled with a three-letter abbreviation which identifies the internal company. E.g. LAA for Laakirchen.'),
country_org_name STRING(100)
OPTIONS(description='The name of the country organization. (This is the country name, as it is known to business. E.g. Germany.)'),
PRIMARY KEY (int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
);