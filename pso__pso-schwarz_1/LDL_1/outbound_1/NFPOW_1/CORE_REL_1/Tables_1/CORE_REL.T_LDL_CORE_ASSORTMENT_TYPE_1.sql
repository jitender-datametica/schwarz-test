/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_core_assortment_type_1
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_core_assortment_type_1 (
ldl_core_assort_type_cd STRING(100) NOT NULL
OPTIONS(description='Code of the type how the item_1 can be regarded to be part of the Lidl core assortment.            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")            LDL:P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE.core_assort_type_cd'),
ldl_core_assort_type_name STRING(100)
OPTIONS(description='Name of the type how items can be regarded to be part of the Lidl core assortment.            CBX: CNT_CODELIST.NAME (code list "lidl_Core_Article")            LDL:P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE.core_assort_type_name'),
ldl_retail_core_assort_fg BOOL
OPTIONS(description='Indicator whether the code classifies the item_1 to be part of the Lidl retail core assortment.            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")            LDL:P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE.retail_core_assort_fg'),
ldl_online_core_assort_fg BOOL
OPTIONS(description='Indicator whether the code classifies the item_1 to be part of the Lidl online core assortment.            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")            LDL:P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE.online_core_assort_fg'),
ldl_online_core_assort_week_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of weeks the classified item_1 is regarded to be part of the Lidl online core assortment.            CBX: CNT_CODELIST.CODE (code list "lidl_Core_Article")            LDL:P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE.online_core_assort_week_cnt'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_core_assort_type_cd) NOT ENFORCED
)
OPTIONS(description='This table containes the types of how items can be regarded to be part of the Lidl core assortment.             CBX: CNT_CODELIST_1 (code list "lidl_Core_Article")             LDL: P_LEW_CORE.T_REF_CORE_ASSORTMENT_TYPE_1');