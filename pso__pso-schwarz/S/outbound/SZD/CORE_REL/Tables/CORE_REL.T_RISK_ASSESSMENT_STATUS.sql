/* --------------------------------------------------------------------------------
   DDL for table: T_RISK_ASSESSMENT_STATUS
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_risk_assessment_status (
risk_assessment_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for it work item status (of project, working package, specification)'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
risk_assessment_status_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the risk assessment status (of SARA or SARA Taks)'),
risk_assessment_type_cd STRING(50) NOT NULL
OPTIONS(description='The static code identifying the risk assessment types (values RA, RAT)'),
risk_assessment_status_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - A name for the risk assessment status (of SARA or SARA Taks)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (risk_assessment_status_id, lang_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - defines the discriminators for risk assessment & assessment task status. Possible status SARA: Stammdaten in Bearbeitung / Relevanzfragen in Bearbeitung & SARA-Task: Offen / In Bearbeitung / Abgeschlossen  - Source - IT4You Service Now');