/* --------------------------------------------------------------------------------
   DDL for table: t_technical_cash_register_event_type
   generated from Powerdesigner on Mittwoch, 15. Mai 2024 11:51:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT_TYPE (
   tech_cash_register_event_type_cd    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of technical cash register event.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   tech_cash_register_event_type_descr VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of technical cash register event.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TECHNICAL_CASH_REGISTER_EVENT_TYPE PRIMARY KEY (tech_cash_register_event_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the kind of technical cash register event. E.g. loging on or off, locking the cash register, etc.';
