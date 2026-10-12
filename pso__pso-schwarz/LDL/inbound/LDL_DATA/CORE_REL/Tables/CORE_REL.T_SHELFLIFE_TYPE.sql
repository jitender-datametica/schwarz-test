/* --------------------------------------------------------------------------------
   DDL for table: t_shelflife_type
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SHELFLIFE_TYPE (
   shelflife_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The code identifying the condition on which a minimum shelflife is defined.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   shelflife_type_descr                VARCHAR(250)    NOT NULL COMMENT 'A textual description for the condition on which a minimum shelflife is defined.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SHELFLIFE_TYPE PRIMARY KEY (shelflife_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the conditon on which a minimum shelflife is defined. E.g. a product may only be offered in a store, if its shelflife is longer than x days. Or it may only be delivered from the warehouse to the store, if its shelflife is longer than y days. ';

