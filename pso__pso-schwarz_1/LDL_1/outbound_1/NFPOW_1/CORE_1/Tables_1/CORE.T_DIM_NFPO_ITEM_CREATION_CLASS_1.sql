/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_item_creation_class_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_item_creation_class_1 (
nfpo_item_creation_class_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO item_1 classification code related to item_1 creation and usage over time.
            CBX: CNT_CODELIST.CODE (code list \'LIDL_ARTICLETYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.ITEM_CLASS_CD'''),
nfpo_item_creation_class_name STRING(100)
OPTIONS(description='''NFPO item_1 classification description related to item_1 creation and usage over time.
            CBX: CTM_CODELIST_BOOK.CUST_TEXT1 (code list \'LIDL_ARTICLETYPE\')
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.ITEM_CLASS'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_creation_class_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO item_1 classification related to item_1 creation and usage over time.
             CBX: CNT_CODELIST_1, code list \'LIDL_ARTICLETYPE\'
             LDL: P_LEW_CORE.T_REF_MDM_ITEM_CLASS_1''');