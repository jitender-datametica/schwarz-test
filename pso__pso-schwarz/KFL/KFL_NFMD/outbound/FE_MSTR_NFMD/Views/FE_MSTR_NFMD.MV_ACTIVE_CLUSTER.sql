CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_active_cluster AS SELECT mandant_id,
 article_cluster_id
FROM kfl_nfmd_core.ts_active_artice_cluster_wbs
QUALIFY (RANK() OVER (PARTITION BY CAST(mandant_id AS STRING) ORDER BY created_at IS NULL DESC, created_at DESC)) = 1;