/* --------------------------------------------------------------------------------
   DDL for table: t_dim_inventory_reason
   generated from Powerdesigner on Mittwoch, 5. März 2025 17:21:45
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_DIM.T_DIM_INVENTORY_REASON (
   inv_reason_id                       NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the reason why an inventory was initiated.',
   inv_reason_descr                    VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reason why an inventory was initiated. (Description in group language, i.e. in German)',
   inv_reason_descr_de                 VARCHAR(250)    COMMENT 'A textual description for the reason why an inventory was initiated. (Description in German)',
   inv_reason_descr_en                 VARCHAR(250)    COMMENT 'A textual description for the reason why an inventory was initiated. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_INVENTORY_REASON PRIMARY KEY (inv_reason_id) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the reason why an inventory was initiated. (The inventory reason only applies to partial inventories.)';
