CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_user_1 (nfpo_user_sid, nfpo_user_acct_name, nfpo_user_first_name,
nfpo_user_last_name, nfpo_user_abbr_name, nfpo_user_mgr_abbr_name, nfpo_user_display_name, is_ekl_user_fg, is_se_user_fg
, is_theme_resp_user_fg, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT nfpo_user_sid,
 nfpo_user_acct_name,
 nfpo_user_first_name,
 nfpo_user_last_name,
 nfpo_user_abbr_name,
 nfpo_user_mgr_abbr_name,
      nfpo_user_first_name || ' ' || nfpo_user_first_name || ' (' || nfpo_user_abbr_name || ')' AS
 nfpo_user_display_name,
 is_ekl_user_fg,
 is_se_user_fg,
 is_theme_resp_user_fg,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_tmsp
FROM nfpow_core.t_dim_nfpo_user_1;