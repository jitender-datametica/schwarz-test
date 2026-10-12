/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_canceling_reason
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BUILDING_CANCELING_REASON CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   canceling_reason_id                 NUMBER(38,0)     NOT NULL COMMENT 'IMS_ESB : identifier for the reason of cancelation: object.status-development.status.status-date.cancellation-reason-id',
   canceling_reason_descr              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'IMS_ESB : description of reason of cancelation: initial load from business',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BUILDING_CANCELING_REASON PRIMARY KEY (client_id, canceling_reason_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Description of the reason for cancelation of building a building';

