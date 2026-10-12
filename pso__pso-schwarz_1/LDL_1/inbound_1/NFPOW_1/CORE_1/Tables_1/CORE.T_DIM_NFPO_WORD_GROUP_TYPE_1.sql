/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_word_group_type_1
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:14:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_WORD_GROUP_TYPE_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_word_grp_type_cd               VARCHAR(100)     NOT NULL,
   nfpo_word_grp_type_name             VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_WORD_GROUP_TYPE PRIMARY KEY (nfpo_word_grp_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the types of word groups. The groups ''unigram'', ''bigram'', ''trigram'' are used so far.';
