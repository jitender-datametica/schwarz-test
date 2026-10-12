/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_international_item_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 11:18:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_international_item_2 (
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL,
ldl_parent_item_ian_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_name STRING(100) NOT NULL,
nfpo_pillar_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_pillar_name STRING(100) NOT NULL
OPTIONS(description='''namne for the identifier of the pillar in CBX, alternative item_2 grouping, groups item_2 family groups
            CBX:Item_2/ldlPillar
            ESB:cbxItem/pillar'''),
nfpo_main_pillar_cd STRING(100) NOT NULL,
nfpo_main_pillar_name STRING(100) NOT NULL
OPTIONS(description='''name  of the main pillar
            CBX: CNT_CODELIST.NAME (code list \'PRODUCT_CATEGORY\')'''),
nfpo_item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_fam_grp_nr STRING(100) NOT NULL,
nfpo_item_fam_grp_name STRING(100) NOT NULL,
nfpo_ldl_brand_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_ldl_brand_nr STRING(100) NOT NULL,
nfpo_ldl_brand_name STRING(100) NOT NULL,
nfpo_brand_type_name STRING(100) NOT NULL,
nfpo_brand_type_cd STRING(100) NOT NULL,
item_origin_type_cd STRING(100) NOT NULL,
nfpo_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Foreign Key NFPO SUPPLIER.
            CBX: CNT_VENDOR.REF_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST.MDM_SUP_SID'''),
nfpo_sup_nr STRING(100) NOT NULL
OPTIONS(description='''NFPO supplier_2 identifier.
            CBX: CNT_VENDOR.REF_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SRC_VENDOR_DOC_REF'''),
nfpo_sup_name STRING(100) NOT NULL
OPTIONS(description='''Name of the NFPO supplier.
            CBX: CNT_VENDOR.BUSINESS_NAME
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME'''),
eks_sup_nr STRING(100)
OPTIONS(description='''Identifier of this subsidiary in EKS.
            CBX: CNT_VENDOR_ADDRESS.LDL_EKS_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST.EKS_SUP_NR'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_ian_nr) NOT ENFORCED
) OPTIONS(description='Comment 2Do');