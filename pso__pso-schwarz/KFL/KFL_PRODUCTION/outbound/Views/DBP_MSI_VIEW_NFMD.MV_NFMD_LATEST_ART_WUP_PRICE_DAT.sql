CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_art_wup_price_dat AS SELECT kjwo_ww,
 mandant_id,
 aktion_id,
 art_id,
 wup_id,
 dwh_created_tmsp AS updated_date,
 manual_promo_price_dt AS manual_price_art_wup_dat
FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_article_store_price_date
QUALIFY (RANK() OVER (PARTITION BY CAST(kjwo_ww AS STRING), CAST(mandant_id AS STRING), aktion_id, CAST(art_id AS STRING)
      , CAST(wup_id AS STRING) ORDER BY dwh_created_tmsp IS NULL DESC, dwh_created_tmsp DESC)) = 1;