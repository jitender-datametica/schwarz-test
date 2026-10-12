/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_RISK_ASSESSMENT_STATUS_2
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_risk_assessment_status_2 (
risk_assessment_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for it work item_2 status_2 (of project, working package_2, specification)'),
risk_assessment_status_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the risk assessment status_2 (of SARA or SARA Taks)'),
risk_assessment_type_cd STRING(50) NOT NULL
OPTIONS(description='The static code identifying the risk assessment types (values RA_2, RAT)'),
risk_assessment_status_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - A name for the risk assessment status_2 (of SARA or SARA Taks)'),
risk_assessment_status_name_de STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for risk assessment status. Language german'),
risk_assessment_status_name_en STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for risk assessment status. Language english'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (risk_assessment_status_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - defines the discriminators for risk assessment & assessment task status. Possible status_2 SARA: Stammdaten in Bearbeitung / Relevanzfragen in Bearbeitung & SARA-Task: Offen / In Bearbeitung / Abgeschlossen  - Source - IT4You Service Now');