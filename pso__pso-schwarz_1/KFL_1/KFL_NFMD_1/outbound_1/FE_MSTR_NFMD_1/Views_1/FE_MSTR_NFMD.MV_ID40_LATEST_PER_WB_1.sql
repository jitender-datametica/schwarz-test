CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_id40_latest_per_wb_1 AS WITH LATEST AS (SELECT aktion_id,
   sku_id,
   wup_id,
   MIN(created_at) AS inital_decison_date,
   MAX(created_at) AS updated_date
  FROM kfl_nfmd_core.ts_id40_perc_wbs_1
  GROUP BY aktion_id,
   sku_id,
   wup_id) (SELECT DISTINCT SC.year_id,
   SC.week_id,
   SC.mandant_id,
   SC.aktion_id,
   SC.sku_id,
   SC.wup_id,
   l.inital_decison_date,
   l.updated_date,
   SC.manual_markdown_percentage,
   SC.manual_markdown_date
  FROM kfl_nfmd_core.ts_id40_perc_wbs_1 AS SC
   INNER JOIN LATEST AS l ON SC.aktion_id = l.aktion_id AND SC.sku_id = l.sku_id AND SC.wup_id = l.wup_id AND SC.created_at
      = l.updated_date);