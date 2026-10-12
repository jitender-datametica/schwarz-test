CREATE TABLE P_LEW_CORE.T_MDM_HIERARCHY_NODE_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   hier_node_sid                       NUMBER(38,0)    NOT NULL COMMENT 'PK Node
            CBX: CNT_ITEM.HIERARCHY_HCL, HIERARCHY_FULL_CODE',
   src_hierarchy_cd                    VARCHAR(20)     NOT NULL COMMENT 'Name of attached hierarchy_1
            CBX: CNT_ITEM.HIERARCHY_HCL',
   src_hier_node_path                  VARCHAR(100)    NOT NULL COMMENT 'Path to node
            CBX: CNT_ITEM.HIERARCHY_FULL_CODE',
   hier_node_cd                        VARCHAR(20)     NOT NULL COMMENT 'Node code
            CBX: CNT_ITEM.HIERARCHY_FULL_CODE',
   hier_node_name                      VARCHAR(100)    COMMENT 'Node name
            CBX: CNT_ITEM.HIERARCHY_FULL_NAME',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_HIERARCHY_NODE PRIMARY KEY (hier_node_sid) NOT ENFORCED 
)  COMMENT = 'NFPO product hierarchy_1
             CBX: derived from CNT_ITEM_1';