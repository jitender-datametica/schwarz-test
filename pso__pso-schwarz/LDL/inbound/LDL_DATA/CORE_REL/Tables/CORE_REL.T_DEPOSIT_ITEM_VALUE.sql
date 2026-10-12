/* --------------------------------------------------------------------------------
   DDL for table: t_deposit_item_value
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DEPOSIT_ITEM_VALUE (
   deposit_item_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the deposit item.',
   country_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   deposit_val                         NUMBER(38, 5)   NOT NULL COMMENT 'The deposit amount for this item. E.g. 25c for a plastic bottle.',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DEPOSIT_ITEM_VALUE PRIMARY KEY (country_sid, deposit_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the deposit amount which is charged for a deposit item, depending on the country.';

