/* --------------------------------------------------------------------------------
   DDL for table: t_technical_cash_register_event_1
   generated from Powerdesigner on Mittwoch, 4. September 2024 14:21:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_1 CLUSTER BY (BUS_DT)(
   tech_cash_register_event_sid        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the technical cash register event. (The surrogate key is unique across all types of cash register events.)',
   cash_register_event_nr              NUMBER(38, 0)   NOT NULL COMMENT 'The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.',
   event_tmsp                          TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the technical cash register event happened. ',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the technical cash register event is counted.',
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store where the technical cash register event happend.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   cash_register_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register which has created this transaction.',
   cash_register_type_cd               VARCHAR(20)     COMMENT 'The code identifying the type of cash register. (standard cash register, self-checkout system, vending machine)',
   cash_register_usg_type_cd           VARCHAR(20)     COMMENT 'The code identifying the way, how a cash register is used. It distinguishes between regular operations, training and maintenance.',
   cashier_hash                        VARCHAR(32)     NOT NULL COMMENT 'The encrypted number of the cashier. (The hash is unique for a given store and a day.)',
   tech_cash_register_event_type_cd    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of technical cash register event.',
   offline_fg                          BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was entered while the cash register was offline.',
   cancel_fg                           BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was cancelled.',
   suspend_fg                          BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was suspended. Some later transaction may resume the suspended transaction to complete it.',
   training_fg                         BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the transaction was entered in training mode, e.g. when a (new) cashier learns how to use the functionalities of the cash register.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TECHNICAL_CASH_REGISTER_EVENT PRIMARY KEY (tech_cash_register_event_sid) NOT ENFORCED
 )  COMMENT= 'Technical cash register events include transactions such as log on / log off, locking or unlocking the cash register reprinting a receipt.';
