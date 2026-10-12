CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_rfq_supplier_list (nfpo_rfq_sup_list_txt,
nfpo_rfq_sup_name_list_txt, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_rfq_supplier_list;