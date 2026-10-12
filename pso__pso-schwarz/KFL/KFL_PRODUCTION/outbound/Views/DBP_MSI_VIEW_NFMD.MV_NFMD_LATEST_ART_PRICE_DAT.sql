CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_art_price_dat AS SELECT kjwo_ww,
 mandant_id,
 art_id,
 dwh_created_tmsp AS updated_date,
 manual_promo_price_dt AS manual_price_art_dat
FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_article_price_date
QUALIFY (RANK() OVER (PARTITION BY CAST(kjwo_ww AS STRING), CAST(mandant_id AS STRING), CAST(art_id AS STRING) ORDER BY
      dwh_created_tmsp IS NULL DESC, dwh_created_tmsp DESC)) = 1;