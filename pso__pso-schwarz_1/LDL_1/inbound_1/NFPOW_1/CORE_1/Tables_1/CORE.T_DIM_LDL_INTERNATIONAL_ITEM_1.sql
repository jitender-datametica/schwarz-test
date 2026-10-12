/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_international_item_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 11:18:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LDL_INTERNATIONAL_ITEM_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_item_ian_nr                     NUMBER(38,0)     NOT NULL,
   ldl_parent_item_ian_nr              NUMBER(38,0)     NOT NULL,
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL,
   nfpo_item_name                      VARCHAR(100)     NOT NULL,
   nfpo_pillar_sid                     NUMBER(38,0)     NOT NULL,
   nfpo_pillar_name                    VARCHAR(100)     NOT NULL COMMENT 'namne for the identifier of the pillar in CBX, alternative item_1 grouping, groups item_1 family groups
            CBX:Item_1/ldlPillar
            ESB:cbxItem/pillar',
   nfpo_main_pillar_cd                 VARCHAR(100)     NOT NULL,
   nfpo_main_pillar_name               VARCHAR(100)     NOT NULL COMMENT 'name  of the main pillar
            CBX: CNT_CODELIST.NAME (code list ''PRODUCT_CATEGORY'')',
   nfpo_item_fam_grp_sid               NUMBER(38,0)     NOT NULL,
   nfpo_item_fam_grp_nr                VARCHAR(100)     NOT NULL,
   nfpo_item_fam_grp_name              VARCHAR(100)     NOT NULL,
   nfpo_ldl_brand_sid                  NUMBER(38,0)     NOT NULL,
   nfpo_ldl_brand_nr                   VARCHAR(100)     NOT NULL,
   nfpo_ldl_brand_name                 VARCHAR(100)     NOT NULL,
   nfpo_brand_type_name                VARCHAR(100)     NOT NULL,
   nfpo_brand_type_cd                  VARCHAR(100)     NOT NULL,
   item_origin_type_cd                 VARCHAR(100)     NOT NULL,
   nfpo_sup_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO SUPPLIER.
            CBX: CNT_VENDOR.REF_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST.MDM_SUP_SID',
   nfpo_sup_nr                         VARCHAR(100)     NOT NULL COMMENT 'NFPO supplier_1 identifier.
            CBX: CNT_VENDOR.REF_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SRC_VENDOR_DOC_REF',
   nfpo_sup_name                       VARCHAR(100)     NOT NULL COMMENT 'Name of the NFPO supplier.
            CBX: CNT_VENDOR.BUSINESS_NAME
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME',
   eks_sup_nr                          VARCHAR(100)     COMMENT 'Identifier of this subsidiary in EKS.
            CBX: CNT_VENDOR_ADDRESS.LDL_EKS_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST.EKS_SUP_NR',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_LDL_INTERNATIONAL_ITEM PRIMARY KEY (ldl_item_ian_nr) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
