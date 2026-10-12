CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_selected_article_cluster_2 AS SELECT mandant_id,
 article_cluster_id,
 1 AS selected_article_cluster_fg
FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_selected_article_cluster_2
QUALIFY (RANK() OVER (PARTITION BY CAST(mandant_id AS STRING) ORDER BY dwh_created_tmsp IS NULL DESC, dwh_created_tmsp
      DESC)) = 1;