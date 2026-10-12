CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_WORD_GROUP_TYPE_2 (
   NFPO_WORD_GRP_TYPE_CD                    COMMENT 'Group type code of key word- Manually filled ("unigram", "bigram" or "trigram")'
  ,NFPO_WORD_GRP_TYPE_NAME                  COMMENT 'Group type code of key word- Manually filled ("unigram", "bigram" or "trigram")'
  ,DISPLAY_SEQ
  ,DWH_CREATED_TMSP                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,DWH_UPDATED_TMSP                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,DWH_SRC_TMSP                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'This table contains the types of word groups. The groups "unigram", "bigram", "trigram" are used so far.'
AS SELECT
   nfpo_word_grp_type_cd
  ,nfpo_word_grp_type_name
  ,CASE
	WHEN nfpo_word_grp_type_name = 'unigram' 	THEN 1
    WHEN nfpo_word_grp_type_name = 'bigram' 	THEN 2
    WHEN nfpo_word_grp_type_name = 'trigram' 	THEN 3 
    ELSE NULL
	END AS display_seq
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp

FROM CORE.T_DIM_NFPO_WORD_GROUP_TYPE_2
;