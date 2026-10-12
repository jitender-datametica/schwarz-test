/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_temporary_closing_reason
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BUILDING_TEMPORARY_CLOSING_REASON CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   temporary_closing_reason_id         NUMBER(38,0)     NOT NULL COMMENT 'IMS_ESB : identifier for the reason of temporary closing : object.temporary-closings.temporary-closing(with-closing="true").reason-id',
   temporary_closing_reason_descr      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'IMS_ESB : description for the reason of closing : initial load from business',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BUILDING_TEMPORARY_CLOSING_REASON PRIMARY KEY (client_id, temporary_closing_reason_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Description of the reason for closing a building (permanently or temporary)';

