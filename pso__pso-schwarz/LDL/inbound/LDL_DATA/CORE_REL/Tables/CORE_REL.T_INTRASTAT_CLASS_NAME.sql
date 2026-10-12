/* --------------------------------------------------------------------------------
   DDL for table: t_intrastat_class_name
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTRASTAT_CLASS_NAME (
   intrastat_nr                        VARCHAR(20)     NOT NULL COMMENT 'The Intrastat number which identifies a certain class of products.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   intrastat_name                      VARCHAR(100)    NOT NULL COMMENT 'The name for the Intrastat code.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INTRASTAT_CLASS_NAME PRIMARY KEY (intrastat_nr, lang_cd) NOT ENFORCED
 )  COMMENT= 'This table provides the translations of the names of an intrastat code in various languages.';

