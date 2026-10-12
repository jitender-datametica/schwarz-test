CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_organization (nfpo_org_sid, nfpo_org_nr, nfpo_org_name,
nfpo_org_descr, nfpo_map_country_name, lob_cd, lob_name, sales_channel_cd, sales_channel_name, display_seq, active_fg,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_organization;