CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_predict_google_review_kaufland_1 (google_place_id, kjmo,
mandant_id, wup_id, predict_review_count, predict_rating_avg) AS SELECT PGR.google_place_id,
 PGR.kjmo,
 PGR.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 PGR.predict_review_count,
 PGR.predict_rating_avg
FROM kfl_production_dbp_view.v_predict_google_review_kaufland_1 AS PGR
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON PGR.mandant_id = WUP.mandant_id AND PGR.wup_id = WUP.wup_id;