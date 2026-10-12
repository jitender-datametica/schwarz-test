-- KFL_NFMD_DEVELOPMENT.FE_MSTR_NFMD.MV_LATEST_ACTIVE_CLUSTER_1 source


CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_latest_active_cluster_1 AS SELECT mandant_id,
 article_cluster_id,
 TRUE AS cluster_active_flag
FROM kfl_nfmd_core.ts_active_artice_cluster_wbs_1
QUALIFY (RANK() OVER (PARTITION BY CAST(mandant_id AS STRING) ORDER BY created_at IS NULL DESC, created_at DESC)) = 1;