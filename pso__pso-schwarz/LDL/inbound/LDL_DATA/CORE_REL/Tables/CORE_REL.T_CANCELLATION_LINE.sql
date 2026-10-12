/* --------------------------------------------------------------------------------
   DDL for table: t_cancellation_line
   generated from Powerdesigner on Dienstag, 9. Juli 2024 18:46:10
*/ --------------------------------------------------------------------------------


CREATE TABLE CORE_REL.T_CANCELLATION_LINE CLUSTER BY (
     COUNTRY_ORG_CD,
     BUS_DT
)(
   retail_event_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales or return of products..',
   retail_event_line_seq               NUMBER(38, 0)   NOT NULL COMMENT 'The number of the line in the retail event.',
   event_tmsp                          TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the cancellation happened.',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   cash_register_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.',
   cash_register_type_cd               VARCHAR(20)     COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
   cash_register_usg_type_cd           VARCHAR(20)     COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.',
   cashier_hash                        VARCHAR(32)     NOT NULL COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)',
   auth_by_hash                        VARCHAR(32)     COMMENT 'In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the encrypted number which identifies the employee, who has authorized the transaction. (The hash is unique for a given store and a day.)',
   cust_sid                            NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the customer.',
   retail_event_line_scenario_id       NUMBER(38, 0)   NOT NULL COMMENT 'The numeric identifier for the scenario which is represented by the retail event line.',
   input_cancel_nr                     VARCHAR(100)    COMMENT 'A number typed in or scanned by the cashier.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CANCELLATION_LINE PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
 )  COMMENT= 'The event of cancelling an erroneus or unwanted product retail line.';
