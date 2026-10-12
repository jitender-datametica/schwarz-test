CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_l_regionalgesellschaft (vs_id, mandant_id, vs_bez) AS SELECT DISTINCT
 V01.vs_id,
 V01.mandant_id,
 V02.vs_bez
FROM kfl_nfmd_core.src_teradata_master_data_wup AS V01
 INNER JOIN kfl_nfmd_core.l_region_ids AS V02 ON V01.mandant_id = V02.mandant_id AND V01.vs_id = V02.vs_id;