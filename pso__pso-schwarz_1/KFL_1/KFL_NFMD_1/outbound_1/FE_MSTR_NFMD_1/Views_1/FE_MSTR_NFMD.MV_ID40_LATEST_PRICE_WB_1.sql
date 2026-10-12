CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_id40_latest_price_wb_1 AS SELECT year_id,
 week_id,
 mandant_id,
 aktion_id,
 sku_id,
 wup_id,
 NULL AS inital_decison_date,
 created_at AS updated_date,
 manual_markdown_price
FROM kfl_nfmd_core.ts_id40_price_wbs_1
QUALIFY (RANK() OVER (PARTITION BY CAST(year_id AS STRING), CAST(week_id AS STRING), CAST(mandant_id AS STRING),
      aktion_id, CAST(sku_id AS STRING), CAST(wup_id AS STRING) ORDER BY created_at IS NULL DESC, created_at DESC)) = 1;