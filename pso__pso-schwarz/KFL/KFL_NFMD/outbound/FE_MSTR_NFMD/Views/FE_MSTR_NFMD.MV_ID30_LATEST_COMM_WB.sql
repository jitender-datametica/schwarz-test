CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_id30_latest_comm_wb AS SELECT year_id,
 week_id,
 mandant_id,
 aktion_id,
 sku_id,
 NULL AS inital_decison_date,
 created_at AS updated_date,
 jf_comment
FROM kfl_nfmd_core.ts_msi_comments_inserts
QUALIFY (RANK() OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), CAST(mandant_id AS STRING),
      aktion_id, CAST(sku_id AS STRING) ORDER BY created_at IS NULL DESC, created_at DESC)) = 1;