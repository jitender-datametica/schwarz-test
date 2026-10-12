CREATE OR REPLACE TABLE ugs_aris_production_core.t_dim_country_organization_2 (
dwh_tenant_cd STRING(8) NOT NULL OPTIONS(description='The code for the data warehoue tenant.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 organization.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
country_org_nr STRING(20) NOT NULL
OPTIONS(description='The number (or code) which identifies the country_2 organization.'),
country_org_name STRING(100) NOT NULL OPTIONS(description='The name by which the country_2 organization is known.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(100)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.')
)
OPTIONS(description='A country_2 organization is an organizational unit_2 within the Schwarz Group which is responsible for the operation in a certain geographical area, typically a political country_2 such as Gemany or France. Few country_2 organizations are responsible for more than one country. E.g. Belgium and Luxemburg are handled by one country_2 organization. Some country_2 organizations cover only a part of a country_2, E.g. the Canary Islands are handeld by a separate country_2 organization.');