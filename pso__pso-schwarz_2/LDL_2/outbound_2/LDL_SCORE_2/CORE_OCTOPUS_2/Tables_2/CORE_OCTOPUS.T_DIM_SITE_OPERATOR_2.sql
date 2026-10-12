CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_site_operator_2 (
site_operator_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the site operator.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
site_operator_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the company for the business.'),
site_operator_abbr_name STRING(100) OPTIONS(description='A short abbreviation for the company that identifies it.'),
site_operator_short_name STRING(100) OPTIONS(description='Short name for company. On CARGO side = <Kurzbezeichnung>'),
site_operator_name STRING(100) OPTIONS(description='The name by which the company is known.'),
site_operator_status_cd STRING(20) NOT NULL
OPTIONS(description='The code for the status_2 of the company. (column  will likely be deleted and table doesn\'t exist on SF)'),
supplier_fg BOOL OPTIONS(description='An indicator showing whether the site operator acts as a supplier_2 for us.'),
hauler_fg BOOL OPTIONS(description='An indicator showing whether the site operator acts as a hauler for us.'),
org_unit_fg BOOL OPTIONS(description='An indicator showing whether the site operator acts as a org unit_2 for us.'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (site_operator_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This dimension contains all companies that we interact with, e.g. Supplier_2 and Hauler and Warehouse Org Units');