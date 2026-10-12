/* --------------------------------------------------------------------------------
   DDL for table: t_cash_register_2
   generated from Powerdesigner on Mittwoch, 5. April 2023 22:05:45
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_CASH_REGISTER_2 (
   cash_register_sid                   NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the cash register.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN          NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   cash_register_nr                    NUMBER(38, 0)    NOT NULL COMMENT 'The number which identifies the cash register.',
   real_estate_sid                     NUMBER(38, 0)    COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)      NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CASH_REGISTER PRIMARY KEY (cash_register_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'A cash register is an electronic device which is used in stores to record sales_2 transactions. It typically includes a bar code scanner, a keyboard, a display and a drawer for money.';
