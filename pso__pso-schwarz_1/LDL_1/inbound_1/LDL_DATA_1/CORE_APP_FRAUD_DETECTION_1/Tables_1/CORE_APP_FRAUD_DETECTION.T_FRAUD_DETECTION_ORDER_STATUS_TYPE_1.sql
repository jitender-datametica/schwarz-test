/* --------------------------------------------------------------------------------
   DDL for table: t_fraud_detection_order_status_type_1
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:11:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_ORDER_STATUS_TYPE_1 (
   order_parameter_status_cd           VARCHAR(20)     NOT NULL COMMENT 'The status_1 of a order parameter if it is approved, requested or denied.',
   order_parameter_status_seq          NUMERIC(38,0)   NOT NULL,
   order_parameter_status_descr        VARCHAR(250)    NOT NULL COMMENT 'Textual describes of the lifecycle status_1',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRAUD_DETECTION_ORDER_STATUS_TYPE PRIMARY KEY (order_parameter_status_cd) NOT ENFORCED
 )  COMMENT= 'This look-up table defines the status_1 of the revision order';
