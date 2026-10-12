CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_pillar_2 (nfpo_pillar_sid, nfpo_pillar_name, dwh_created_tmsp,
dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_pillar_2;