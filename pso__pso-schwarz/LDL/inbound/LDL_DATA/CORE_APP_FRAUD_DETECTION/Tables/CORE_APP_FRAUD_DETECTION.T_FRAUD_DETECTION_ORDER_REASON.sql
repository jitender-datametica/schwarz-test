/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_order_reason
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:10:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_REASON (
   order_reason_cd                     VARCHAR(20)     NOT NULL COMMENT 'The revision reason code for an analysis, if it is for threshold definition or fraud analysis',
   order_reason_descr                  VARCHAR(250)    NOT NULL COMMENT 'Textual description for the order reason',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_ORDER_REASON PRIMARY KEY (order_reason_cd) NOT ENFORCED
 )  COMMENT= 'Reason why the fraud detection was ordered.Reason (for example):Inter audit, rparameter defition';
