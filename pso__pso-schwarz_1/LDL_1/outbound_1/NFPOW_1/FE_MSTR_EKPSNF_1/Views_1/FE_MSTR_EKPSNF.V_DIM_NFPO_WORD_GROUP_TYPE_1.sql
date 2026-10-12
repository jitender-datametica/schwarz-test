CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_word_group_type_1 (nfpo_word_grp_type_cd
OPTIONS(description='Group type code of key word- Manually filled ("unigram", "bigram" or "trigram")'),
nfpo_word_grp_type_name
OPTIONS(description='Group type code of key word- Manually filled ("unigram", "bigram" or "trigram")'), display_seq,
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE TYPES OF WORD GROUPS. THE GROUPS "UNIGRAM", "BIGRAM", "TRIGRAM" ARE USED SO FAR.`)
AS SELECT nfpo_word_grp_type_cd,
 nfpo_word_grp_type_name,
  CASE
  WHEN nfpo_word_grp_type_name = 'unigram'
  THEN 1
  WHEN nfpo_word_grp_type_name = 'bigram'
  THEN 2
  WHEN nfpo_word_grp_type_name = 'trigram'
  THEN 3
  ELSE NULL
  END AS display_seq,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_tmsp
FROM nfpow_core.t_dim_nfpo_word_group_type_1;