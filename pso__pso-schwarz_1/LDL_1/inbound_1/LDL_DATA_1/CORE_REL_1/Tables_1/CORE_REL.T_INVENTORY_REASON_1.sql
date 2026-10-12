/* --------------------------------------------------------------------------------
   DDL for table: t_inventory_reason_1
   generated from Powerdesigner on Freitag, 6. Dezember 2024 18:24:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INVENTORY_REASON_1 (
   inv_reason_id                       NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the reason why an inventory was initiated.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   inv_reason_descr                    VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason why an inventory was initiated.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INVENTORY_REASON PRIMARY KEY (inv_reason_id, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the reason why an inventory was initiated.';

