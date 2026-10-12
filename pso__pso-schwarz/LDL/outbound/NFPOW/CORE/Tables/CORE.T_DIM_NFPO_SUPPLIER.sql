/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_supplier
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 14:53:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_supplier (
nfpo_sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO SUPPLIER.            CBX: CNT_VENDOR.REF_NO            LDL: P_LEW_CORE.T_MDM_SUPPLIER.MDM_SUP_SID            CORE_REL: t_nfpo_supplier.nfpo_sup_sid'),
nfpo_sup_nr STRING(100) NOT NULL
OPTIONS(description='NFPO supplier identifier.            CBX: CNT_VENDOR.REF_NO            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SRC_VENDOR_DOC_REF            CORE_REL: t_nfpo_supplier.nfpo_sup_nr'),
nfpo_sup_name STRING(100) NOT NULL
OPTIONS(description='Name of the NFPO supplier.            CBX: CNT_VENDOR.BUSINESS_NAME            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME            CORE_REL: t_nfpo_supplier.nfpo_sup_name'),
nfpo_gtin_ownership_cd STRING(100) NOT NULL
OPTIONS(description='NFPO GTIN assignment responsibility code.            CBX: CTM_VENDOR.CUST_CODELIST1            LDL: P_LEW_CORE.T_MDM_SUPPLIER_HIST.EAN_OWNERSHIP_CD            CORE_REL: t_nfpo_supplier_hist.nfpo_gtin_ownership_cd'),
nfpo_gtin_ownership_descr STRING(250)
OPTIONS(description='NFPO GTIN assignment responsibility descriptions.            CBX: CNT_CODELIST.NAME (code list "LIDL_GTIN_OUTPUT")            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP            CORE: t_dim_nfpo_gtin_ownership.nfpo_gtin_ownership_descr'),
nfpo_country_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key main supplier subsidiary country the address is located in              CBX: CNT_VENDOR_ADDRESS.COUNTRY            LDL: P_LEW_CORE.T_ADDRESS.COUNTRY_POL_SID            CORE_REL: t_nfpo_address.nfpo_country_sid'),
nfpo_country_cd STRING(100) NOT NULL
OPTIONS(description='main supplier subsidiary country code the address is located in             CBX: CNT_VENDOR_ADDRESS.COUNTRY            LDL: P_LEW_CORE.T_ADDRESS.COUNTRY_POL_CD            CORE_REL: t_nfpo_address.nfpo_country_cd'),
nfpo_country_name STRING(100)
OPTIONS(description='main supplier subsidiary country name the address is located in            CBX: cnt_codelis.tname;            LDL: P_LEW_CORE.t_country_political.country_pol_name            CORE_REL: t_nfpo_country.nfpo_country_name'),
street_name STRING(100)
OPTIONS(description='main supplier subsidiary street name the address is located in             CBX: CNT_VENDOR_ADDRESS.ADDRESS1            LDL: P_LEW_CORE.T_ADDRESS.STREET            CORE_REL: t_nfpo_address.street_name'),
city_name STRING(100)
OPTIONS(description='main supplier subsidiary city name the address is located in            CBX: CNT_VENDOR_ADDRESS.CITY            LDL: P_LEW_CORE.T_ADDRESS.CITY            CORE_REL: t_nfpo_address.city_name'),
zip STRING(15)
OPTIONS(description='main supplier subsidiary address zip code            CBX: CNT_VENDOR_ADDRESS.POSTAL_CODE            LDL: P_LEW_CORE.T_ADDRESS.ZIP_CODE            CORE_REL: t_nfpo_address.zip'),
eks_sup_nr STRING(100)
OPTIONS(description='EKS supplier number.            CBX: CNT_VENDOR.REFERENCE            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NR            CORE_REL: t_nfpo_supplier.eks_sup_nr'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_sup_sid) NOT ENFORCED
)
OPTIONS(description='NFPO related vendor definition.             CBX: CNT_VENDOR, CTM_VENDOR             LDL: P_LEW_CORE.T_MDM_SUPPLIER             CORE_REL: T_NFPO_SUPPLIER');