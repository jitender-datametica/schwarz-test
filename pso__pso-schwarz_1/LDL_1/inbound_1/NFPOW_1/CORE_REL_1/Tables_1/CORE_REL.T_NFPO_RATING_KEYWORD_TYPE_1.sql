/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_rating_keyword_type_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:32:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_RATING_KEYWORD_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_rating_keyword_type_cd         VARCHAR(100)     NOT NULL COMMENT 'Code for the discriminator values for keyword types used in nfpo rating.
            LDL: p_lew_core.t_ref_item_rating_keyword_type.item_rating_keyword_type_cd',
   nfpo_rating_keyword_type_descr      VARCHAR(250)     NOT NULL COMMENT 'A textual description for the discriminator value for keyword types used in nfpo item_1 rating.
            LDL: p_lew_core.t_ref_item_rating_keyword_type.item_keyword_type_descr',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: LDL: p_lew_core.t_customer_experience_information_provider.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_RATING_KEYWORD_TYPE PRIMARY KEY (nfpo_rating_keyword_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the data providers for customer experience data. This can be a platform operator (Google, etc.) a market rearch company, or the retailer itself.
             LDL: p_lew_core.t_ref_item_rating_keyword_type';
