CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ejr_acct_disposition_1 (accounting_disposition_cd_ejr, comment_string
, language_id, dat_lastedit, user_lastedit, load_id) AS SELECT accounting_disposition_cd_ejr,
 comment_string,
 language_id,
 dat_lastedit,
 user_lastedit,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ejr_acct_disposition_1;