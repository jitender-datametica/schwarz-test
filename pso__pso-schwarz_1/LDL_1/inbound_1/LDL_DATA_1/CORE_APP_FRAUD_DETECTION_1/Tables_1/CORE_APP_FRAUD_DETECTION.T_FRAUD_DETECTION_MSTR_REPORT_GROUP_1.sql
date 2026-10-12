/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_mstr_report_group_1
   generated from Powerdesigner on Montag, 14. Oktober 2024 12:38:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_MSTR_REPORT_GROUP_1 (
   report_grp_id                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of fraud detection report group.',
   report_grp_name                     VARCHAR(100)    NOT NULL COMMENT 'The name of the identified dynamic report group',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_MSTR_REPORT_GROUP PRIMARY KEY (report_grp_id) NOT ENFORCED
 )  COMMENT= 'Holds the report groups for dynamic dashboarding like "Cancel", "Returns"...';
