/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_word_group_2
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:13:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_WORD_GROUP_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_word_grp_txt                   VARCHAR(1000)    NOT NULL COMMENT 'A word that is used in the rating comment and has been identified as key word
            LDL: p_lew_core.t_item_rating_element_keyword.keyword_unigram_txt',
   nfpo_word_grp_type_cd               VARCHAR(100)     NOT NULL,
   nfpo_word_grp_type_name             VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_WORD_GROUP PRIMARY KEY (nfpo_word_grp_txt, nfpo_word_grp_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the list of word groups identified in ratings.';
