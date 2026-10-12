/* --------------------------------------------------------------------------------
   DDL for table: t_subtotal_line_1
   generated from Powerdesigner on Mittwoch, 15. Mai 2024 11:59:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SUBTOTAL_LINE_1 CLUSTER BY (
     COUNTRY_ORG_CD,
     BUS_DT
)(
   retail_event_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related retail transaction, i.e. for the sales_1 or return of products..',
   retail_event_line_seq               NUMBER(38, 0)   NOT NULL COMMENT 'The number of the line in the retail event.',
   event_tmsp                          TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the subtotal was calculated.',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the related retail event happend.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   cash_register_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.',
   cash_register_type_cd               VARCHAR(20)     COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
   cash_register_usg_type_cd           VARCHAR(20)     COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.',
   cashier_hash                        VARCHAR(32)     NOT NULL COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)',
   cust_sid                            NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the customer.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SUBTOTAL_LINE PRIMARY KEY (retail_event_sid, retail_event_line_seq) NOT ENFORCED
 )  COMMENT= 'An event displaying the current amount of a retail event in progress.';

