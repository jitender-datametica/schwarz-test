/* --------------------------------------------------------------------------------
   DDL for table: t_retail_line_entry_method
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 17:38:51
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_RETAIL_LINE_ENTRY_METHOD (
   retail_line_entry_method_cd         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   retail_line_entry_method_descr      VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_RETAIL_LINE_ENTRY_METHOD PRIMARY KEY (retail_line_entry_method_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the way, how a retail line is entered into the cash register, i.e. if the product is scanned, or if it is entered via the keyboard.';