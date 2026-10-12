CREATE OR REPLACE TABLE ugs_aris_production_core.t_dim_process_workflow_status_lng_1 (
process_workflow_status_cd STRING(5) NOT NULL
OPTIONS(description='The code for the step in the approval process of a process.'),
lng_cd STRING(2) NOT NULL
OPTIONS(description='The code for the language according to ISO-639-1. E.g.\"DE\" for German.'),
process_workflow_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description in the language indicated by the language code for the approval step of a process.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.')
)
OPTIONS(description='The workflow status_1 details the process status_1 by defining the approval steps which are required before a process can be rolled out. This table contains the corresponding textual descriptions in various languages. There is one record for each type of process model and language.');