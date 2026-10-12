CREATE TABLE P_LEW_CORE.T_ITEM_MDM_LINK_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'surrogate key of the ERP client of the item_2 related to the NFPO item_2 instance',
   item_sid                            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key of the ERP system based item_2 variant (overarching unique, not just within a certain client)',
   client_item_role_cd                 VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'role of the ERP system based item_2 variant in the relation to the cbx based item_2',
   mdm_item_sid                        NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO item_2 instance',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_ITEM_MDM_LINK PRIMARY KEY (mdm_item_sid, item_sid) NOT ENFORCED 
)  COMMENT = 'relation between NFPO items and local ERP system based items
             populated by algorithm using t_item_2 and t_mdm_item_2 and the IAN of the NFPO item_2';