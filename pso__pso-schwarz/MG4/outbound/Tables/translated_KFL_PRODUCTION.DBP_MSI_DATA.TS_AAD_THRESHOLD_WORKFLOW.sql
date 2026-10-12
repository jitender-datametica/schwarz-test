CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ts_aad_threshold_workflow (
threshold_request_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Request (Sequence)'),
dwh_created_tmsp DATETIME NOT NULL
OPTIONS(description='Timestamp when this record (version) of the Request was created. '),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
region_id INTEGER NOT NULL
OPTIONS(description='Region eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region gebildet'),
scenario_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
scenario_metric_id INTEGER NOT NULL
OPTIONS(description='Unique identifier of the metric that is monitored in fraud detection scenarios'),
creator_user_id STRING(255) OPTIONS(description='AD name of the user who created the request'),
scenario_metric_threshold_init_val NUMERIC(18,4)
OPTIONS(description='The current scenario threshold value, This is used for calculations'),
scenario_metric_user_val NUMERIC(18,4)
OPTIONS(description='The current scenario threshold value, This is used for calculations'),
request_status_type_id INTEGER
OPTIONS(description='Id of the types of statuses a request can have: default 0=open, 1= approved, 2=rejected'),
creation_reason_comment_txt STRING(255)
OPTIONS(description='Describes the justification entered by the applicant - why the request was created'),
approver_comment_txt STRING(255) OPTIONS(description='Comment entered by the person who approves the request'),
expiration_tmsp DATETIME OPTIONS(description='Timestmap when at which point request expires and is no logner valid'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (threshold_request_id, dwh_created_tmsp) NOT ENFORCED
) OPTIONS(description='Contains information about request to change values of metrics scenario metric thresholds.');