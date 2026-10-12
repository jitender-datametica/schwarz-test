CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_logistics_framework_agreement_1 (
logistics_framework_agmt_sid BIGNUMERIC NOT NULL OPTIONS(description='Agreement unique identifier'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
logistics_framework_agmt_name STRING(100)
OPTIONS(description='A name that is used to identify a logistic framework agreement'),
org_unit_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the organization unit.'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company.'),
logistics_area_fg BOOL OPTIONS(description='If framework agreement is relevant for logistics area'),
import_area_fg BOOL OPTIONS(description='If framework agreement  is relevant for import area'),
validity_period_from_tmsp TIMESTAMP OPTIONS(description='Agreement valid from date'),
validity_period_to_tmsp TIMESTAMP OPTIONS(description='Agreement valid to date'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (logistics_framework_agmt_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='CDM: Logistik-Rahmenvertrag. A logistics framework agreement describes the agreement between two contracting parties (logistics service provider and internal organizational unit_1).');