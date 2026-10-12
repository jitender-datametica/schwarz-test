/* --------------------------------------------------------------------------------
   DDL for table: t_inventory_statistics_type_2
   generated from Powerdesigner on Freitag, 6. Dezember 2024 18:24:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INVENTORY_STATISTICS_TYPE_2 (
   inv_stat_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of stasticis value that is calculated for an inventory.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   inv_stat_type_descr                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of stasticis value that is calculated for an inventory.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INVENTORY_STATISTICS_TYPE PRIMARY KEY (inv_stat_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the kind of stasticis value that is calculated for an inventory.';

