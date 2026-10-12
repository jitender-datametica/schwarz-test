/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RISK_ASSESSMENT
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_risk_assessment (
agreement_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier (surrogate key)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
risk_assessment_nr STRING(250) NOT NULL OPTIONS(description='Natural Key/Business Key - SARA Business Key'),
risk_assessment_name STRING(500) NOT NULL OPTIONS(description='Descriptive Attribute - SARA name in IT4U source system'),
source_sys_nr STRING(100) NOT NULL
OPTIONS(description='Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.'),
source_updated_on_tmsp TIMESTAMP
OPTIONS(description='Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (agreement_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Schwarz Agile Risk assessment process (e.g. SARA) for a specific working package or project, which will be assessed for risks like infosec - Source - IT4You ServiceNow');