CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_sales_channel (sales_channel_cd, sales_channel_name, dwh_created_tmsp
, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_sales_channel;