/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_rating_bias_type_2
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:10:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_RATING_BIAS_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_rating_bias_type_cd            VARCHAR(100)     NOT NULL,
   nfpo_rating_bias_type_name          VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_RATING_BIAS_TYPE PRIMARY KEY (nfpo_rating_bias_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains bias types of ratings from different sources. If the source is classified as ''neutral'', then ''unbiased'' is used, if the source is a CRM system which mainly is used to handle customer complaints, then ''complaint'' is used.';
