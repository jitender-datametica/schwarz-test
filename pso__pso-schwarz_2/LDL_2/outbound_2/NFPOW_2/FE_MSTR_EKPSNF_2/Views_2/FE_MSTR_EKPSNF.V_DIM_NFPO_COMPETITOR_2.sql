CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_competitor_2 (nfpo_competitor_sid, nfpo_competitor_cd,
nfpo_competitor_name, nfpo_competitor_abbr_name, is_competitor_1_fg, is_competitor_2_fg, dwh_created_tmsp,
dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_competitor_2;