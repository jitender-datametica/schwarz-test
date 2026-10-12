/* --------------------------------------------------------------------------------
   DDL for table: t_intrastat_class
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTRASTAT_CLASS (
   intrastat_nr                        VARCHAR(20)     NOT NULL COMMENT 'The Intrastat number which identifies a certain class of products.',
   intrastat_name                      VARCHAR(100)    NOT NULL COMMENT 'The name for the Intrastat number.',
   parent_intrastat_nr                 VARCHAR(20)     COMMENT 'Intrastat numbers form a hierarchy. This is the upper level element in the hierarchy.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INTRASTAT_CLASS PRIMARY KEY (intrastat_nr) NOT ENFORCED
 )  COMMENT= 'This minor entity contains the product classification codes according to Intrastat. (EU regulation 638/2004)';

