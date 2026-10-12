CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_internal_contract_partner_2 (
internal_contract_partner_sid BIGNUMERIC NOT NULL
OPTIONS(description='Unique identifier for the internal contract partner'),
internal_contract_partner_nr STRING(20) OPTIONS(description='The number which identifies the internal contract partner'),
internal_contract_partner_name STRING(100) OPTIONS(description='The name of the internal contract partner'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (internal_contract_partner_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The dimension contains internal organizations which act as contractual partners for logistics agreements. For inbound logistics this would be the following: LExI, OWIM, EMB/IBL KG, PreZero,...             ');