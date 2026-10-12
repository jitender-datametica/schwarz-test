/* --------------------------------------------------------------------------------
   DDL for table: t_retail_event
   generated from Powerdesigner on Dienstag, 30. Juli 2024 22:31:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_RETAIL_EVENT CLUSTER BY (
     COUNTRY_ORG_CD,
     BUS_DT
)(
   retail_event_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the retail event, i.e. for the sales or return of products.. (The surrogate key is unique across all types of cash register events.)',
   cash_register_event_nr              NUMBER(38, 0)   NOT NULL COMMENT 'The sequence number of the cash register transaction. It is unique to the cash register, but might be re-cycled after some time.',
   event_start_tmsp                    TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the retail event started.',
   event_end_tmsp                      TIMESTAMP_TZ(9) NOT NULL COMMENT 'The end timestamp of the retail event.',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event is counted.',
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the retail event happend.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   cash_register_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.',
   cash_register_type_cd               VARCHAR(20)     COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
   cash_register_usg_type_cd           VARCHAR(20)     COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.',
   cashier_hash                        VARCHAR(32)     NOT NULL COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)',
   auth_by_hash                        VARCHAR(32)     COMMENT 'In case of a cancellation or any other non-standard operation, the transaction must be authorized by the store manager or by another employee. This is the encrypted number which identifies the employee, who has authorized the transaction. (The hash is unique for a given store and a day.)',
   cust_sid                            NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the customer.',
   cust_ident_type_cd                  VARCHAR(20)     COMMENT 'The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.',
   retail_event_type_cd                VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for retail events.',
   retail_event_scenario_id            NUMBER(38, 0)   NOT NULL COMMENT 'The numeric identifier for the scenario which is represented by the retail event.',
   offline_fg                          BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was entered while the cash register was offline.',
   cancel_fg                           BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was cancelled.',
   suspend_fg                          BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.',
   susp_retail_event_sid               NUMBER(38, 0)   COMMENT 'In case this retail event continued another cash register transaction which was suspended, this is the identifier of the suspended retail event.',
   training_fg                         BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.',
   txn_gross_val                       NUMBER(38, 5)   NOT NULL COMMENT 'The total gross amount of the retail transaction. (amount in the currency defined by the currency code)',
   txn_net_val                         NUMBER(38, 5)   NOT NULL COMMENT 'The total net amount of the retail transaction. (amount in the currency defined by the currency code)',
   txn_vat_val                         NUMBER(38, 5)   NOT NULL COMMENT 'The total VAT amount of the retail transaction. (amount in the currency defined by the currency code)',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   turnover_relevant_fg                BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the retail event is to be considered as relevant for the turnover calculation.',
   service_tm_sec_meas                 NUMBER(38, 5)   COMMENT 'The time in seconds needed for entering all lines of the transaction.',
   paym_tm_sec_meas                    NUMBER(38, 5)   COMMENT 'The time in seconds needed for the payment (or return of money to the customer)',
   scanned_lines_cnt                   NUMBER(38, 0)   COMMENT 'The number of lines on this receipt which have been scanned.',
   keyed_lines_cnt                     NUMBER(38, 0)   COMMENT 'The number of lines on this receipt which have been manually keyed in.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_RETAIL_EVENT PRIMARY KEY (retail_event_sid) NOT ENFORCED
)  COMMENT= 'A retail transaction is the process of selling products to customers or the process of accepting returned products. Each retail transaction is documented on a receipt. A receipt contains several lines.';
