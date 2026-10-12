CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_proposed_decision_1 AS SELECT kjwo_ww,
 mandant_id,
 art_id,
 dwh_created_tmsp AS updated_date,
 markdown_decision_id
FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_proposed_decision_1
QUALIFY (RANK() OVER (PARTITION BY CAST(kjwo_ww AS STRING), CAST(mandant_id AS STRING), CAST(art_id AS STRING) ORDER BY
      dwh_created_tmsp IS NULL DESC, dwh_created_tmsp DESC)) = 1;