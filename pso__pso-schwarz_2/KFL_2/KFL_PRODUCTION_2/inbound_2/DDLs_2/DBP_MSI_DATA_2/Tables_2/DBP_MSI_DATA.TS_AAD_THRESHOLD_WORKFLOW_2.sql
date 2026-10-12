--==============================================================
-- Table: ts_aad_threshold_workflow_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_aad_threshold_workflow_2
   generated from Powerdesigner on Montag, 12. Juni 2023 07:56:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_AAD_THRESHOLD_WORKFLOW_2 (
   threshold_request_id                NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Request (Sequence)',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp when this record (version) of the Request was created. ',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
   region_id                           NUMBER(38,0)     NOT NULL COMMENT 'Region_2 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_2 gebildet',
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   scenario_metric_id                  NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the metric that is monitored in fraud detection scenarios',
   creator_user_id                     VARCHAR(255)     COMMENT 'AD name of the user who created the request',
   scenario_metric_threshold_init_val  NUMBER(18,4)     COMMENT 'The current scenario threshold value, This is used for calculations',
   scenario_metric_user_val            NUMBER(18,4)     COMMENT 'The current scenario threshold value, This is used for calculations',
   request_status_type_id              NUMBER(38,0)     COMMENT 'Id of the types of statuses a request can have: default 0=open, 1= approved, 2=rejected',
   creation_reason_comment_txt         VARCHAR(255)     COMMENT 'Describes the justification entered by the applicant - why the request was created',
   approver_comment_txt                VARCHAR(255)     COMMENT 'Comment entered by the person who approves the request',
   expiration_tmsp                     TIMESTAMP_NTZ(9) COMMENT 'Timestmap when at which point request expires and is no logner valid',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AAD_THRESHOLD_WORKFLOW PRIMARY KEY (threshold_request_id, dwh_created_tmsp) NOT ENFORCED
)  COMMENT = 'Contains information about request to change values of metrics scenario metric thresholds.';
