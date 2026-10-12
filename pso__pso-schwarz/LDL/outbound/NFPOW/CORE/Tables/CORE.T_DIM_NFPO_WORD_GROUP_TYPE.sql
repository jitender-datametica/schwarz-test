/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_word_group_type
   generated from Powerdesigner on Mittwoch, 24. Januar 2024 15:14:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_word_group_type (
nfpo_word_grp_type_cd STRING(100) NOT NULL,
nfpo_word_grp_type_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_word_grp_type_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the types of word groups. The groups\'unigram\',\'bigram\',\'trigram\' are used so far.');