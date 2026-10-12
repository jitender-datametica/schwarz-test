CREATE TABLE P_LEW_CORE.T_REF_MDM_BUYER_ROLE_TYPE_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   role_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'type code of the role a NFPO user can be assigned to for a specific item_2 in the range selection process',
   role_type                           VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'name of the role a user can be assigned to for a specific item_2 in the range selection process',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_REF_MDM_BUYER_ROLE_TYPE PRIMARY KEY (role_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO user role type;
             Static reference data:
             1: EKL: Purchasing Manager
             2: SE: Category Manager (Hardware only)
             3: KVW: Contract Manager
             4: KP: Contract Approver';