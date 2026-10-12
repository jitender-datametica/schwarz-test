/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_AGENT
   generated from Powerdesigner on Dienstag, 8. August 2023 13:19:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_customs_agent (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the custom agent '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
customs_agent_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the custom agent '),
source_customs_agent_name_address_city_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - the name of the  customs agent directly from source. Source: VMT'),
status_cd STRING(50) OPTIONS(description='The status code for the company'),
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
OPTIONS(description='Major Dimension - Customs agent, responsible for customs handling in the destination harbors. - Source - VMT');