CREATE OR REPLACE TABLE szd_production_core.t_dim_quality_check_institute_1 (
party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the quality check institute'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
qci_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the quality check institute'),
source_qci_name_address_city_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - the name of the quality check institute directly from source. Source: VMT'),
status_cd STRING(50) NOT NULL OPTIONS(description='The status_1 code for the company'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A company which managing quality check of bought goods (QCI = Quality Check Institute). - Source - VMT');