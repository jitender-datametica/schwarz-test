CREATE TABLE P_LEW_CORE.T_SUPPLIER_MDM_LINK_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'surrogate key of the ERP client of the supplier_2 related to the NFPO supplier_2',
   sup_sid                             NUMBER(38,0)    NOT NULL COMMENT 'foreign key of the ERP based supplier_2 related to the NFPO supplier_2',
   mdm_sup_sid                         NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO supplier_2
            CBX: CNT_VENDOR.REF_NO',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_SUPPLIER_MDM_LINK PRIMARY KEY (sup_sid, mdm_sup_sid) NOT ENFORCED 
)  COMMENT = 'Supplier_2 master link; based on EKS supplier_2 number';