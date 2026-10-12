/* --------------------------------------------------------------------------------
   DDL for table: t_data_quality_rule_type_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_QUALITY_RULE_TYPE_1 (
   dq_rule_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'A code for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
   dq_rule_type_descr                  VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_RULE_TYPE PRIMARY KEY (dq_rule_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the subtype discriminators for data quality rules. It distinguishes between business rules, generated and parametrized rules.';
