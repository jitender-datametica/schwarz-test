/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_supplier_2
   generated from Powerdesigner on Dienstag, 22. Oktober 2024 14:53:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_SUPPLIER_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_sup_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO SUPPLIER.
            CBX: CNT_VENDOR.REF_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.MDM_SUP_SID
            CORE_REL: t_nfpo_supplier.nfpo_sup_sid',
   nfpo_sup_nr                         VARCHAR(100)     NOT NULL COMMENT 'NFPO supplier_2 identifier.
            CBX: CNT_VENDOR.REF_NO
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SRC_VENDOR_DOC_REF
            CORE_REL: t_nfpo_supplier.nfpo_sup_nr',
   nfpo_sup_name                       VARCHAR(100)     NOT NULL COMMENT 'Name of the NFPO supplier.
            CBX: CNT_VENDOR.BUSINESS_NAME
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME
            CORE_REL: t_nfpo_supplier.nfpo_sup_name',
   nfpo_gtin_ownership_cd              VARCHAR(100)     NOT NULL COMMENT 'NFPO GTIN assignment responsibility code.
            CBX: CTM_VENDOR.CUST_CODELIST1
            LDL: P_LEW_CORE.T_MDM_SUPPLIER_HIST.EAN_OWNERSHIP_CD
            CORE_REL: t_nfpo_supplier_hist.nfpo_gtin_ownership_cd',
   nfpo_gtin_ownership_descr           VARCHAR(250)     COMMENT 'NFPO GTIN assignment responsibility descriptions.
            CBX: CNT_CODELIST.NAME (code list "LIDL_GTIN_OUTPUT")
            LDL: P_LEW_CORE.T_REF_MDM_EAN_OWNERSHIP.EAN_OWNERSHIP
            CORE: t_dim_nfpo_gtin_ownership.nfpo_gtin_ownership_descr',
   nfpo_country_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key main supplier_2 subsidiary country_2 the address_2 is located in  
            CBX: CNT_VENDOR_ADDRESS.COUNTRY_2
            LDL: P_LEW_CORE.T_ADDRESS.COUNTRY_POL_SID
            CORE_REL: t_nfpo_address.nfpo_country_sid',
   nfpo_country_cd                     VARCHAR(100)     NOT NULL COMMENT 'main supplier_2 subsidiary country_2 code the address_2 is located in 
            CBX: CNT_VENDOR_ADDRESS.COUNTRY_2
            LDL: P_LEW_CORE.T_ADDRESS.COUNTRY_POL_CD
            CORE_REL: t_nfpo_address.nfpo_country_cd',
   nfpo_country_name                   VARCHAR(100)     COMMENT 'main supplier_2 subsidiary country_2 name the address_2 is located in
            CBX: cnt_codelis.tname;
            LDL: P_LEW_CORE.t_country_political.country_pol_name
            CORE_REL: t_nfpo_country.nfpo_country_name',
   street_name                         VARCHAR(100)     COMMENT 'main supplier_2 subsidiary street name the address_2 is located in 
            CBX: CNT_VENDOR_ADDRESS.ADDRESS1
            LDL: P_LEW_CORE.T_ADDRESS.STREET
            CORE_REL: t_nfpo_address.street_name',
   city_name                           VARCHAR(100)     COMMENT 'main supplier_2 subsidiary city name the address_2 is located in
            CBX: CNT_VENDOR_ADDRESS.CITY
            LDL: P_LEW_CORE.T_ADDRESS.CITY
            CORE_REL: t_nfpo_address.city_name',
   zip                                 VARCHAR(15)      COMMENT 'main supplier_2 subsidiary address_2 zip code
            CBX: CNT_VENDOR_ADDRESS.POSTAL_CODE
            LDL: P_LEW_CORE.T_ADDRESS.ZIP_CODE
            CORE_REL: t_nfpo_address.zip',
   eks_sup_nr                          VARCHAR(100)     COMMENT 'EKS supplier_2 number.
            CBX: CNT_VENDOR.REFERENCE
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NR
            CORE_REL: t_nfpo_supplier.eks_sup_nr',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_SUPPLIER PRIMARY KEY (nfpo_sup_sid) NOT ENFORCED 
)  COMMENT = 'NFPO related vendor definition.
             CBX: CNT_VENDOR_2, CTM_VENDOR_2
             LDL: P_LEW_CORE.T_MDM_SUPPLIER_2
             CORE_REL: T_NFPO_SUPPLIER_2';
