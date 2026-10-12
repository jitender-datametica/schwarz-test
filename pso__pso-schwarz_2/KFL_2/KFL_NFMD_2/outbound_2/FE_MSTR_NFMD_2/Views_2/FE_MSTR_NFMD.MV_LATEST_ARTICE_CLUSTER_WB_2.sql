CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_latest_artice_cluster_wb_2 AS SELECT year_id,
 week_id,
 mandant_id,
 aktion_id,
 sku_id,
 created_at AS updated_date,
 article_cluster_id
FROM kfl_nfmd_core.ts_artice_cluster_wbs_2
QUALIFY (RANK() OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), CAST(mandant_id AS STRING),
      aktion_id, sku_id ORDER BY created_at IS NULL DESC, created_at DESC)) = 1;