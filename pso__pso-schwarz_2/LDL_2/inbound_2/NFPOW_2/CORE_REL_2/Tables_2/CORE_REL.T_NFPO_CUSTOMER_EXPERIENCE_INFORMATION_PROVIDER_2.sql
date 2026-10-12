/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_customer_experience_information_provider_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:36:38
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_CUSTOMER_EXPERIENCE_INFORMATION_PROVIDER_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_cx_info_provider_nr            VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.
            LDL: p_lew_core.t_customer_experience_information_provider.cx_info_provider_nr',
   nfpo_cx_info_provider_descr         VARCHAR(250)     COMMENT 'Description of the provider or collector of the customer experience information.
            LDL: p_lew_core.t_customer_experience_information_provider.cx_info_provider_descr',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_CUSTOMER_EXPERIENCE_INFORMATION_PROVIDER PRIMARY KEY (nfpo_cx_info_provider_nr) NOT ENFORCED 
)  COMMENT = 'This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.
             LDL: p_lew_core.t_customer_experience_information_provider_2';
