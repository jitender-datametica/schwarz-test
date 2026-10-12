CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_predict_competitors_kaufland_zu_2 (google_place_id, kjmo,
mandant_id, wup_id, airline_distance) AS SELECT PCK.google_place_id,
 PCK.kjmo,
 PCK.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 PCK.airline_distance
FROM kfl_production_dbp_view.v_predict_competitors_kaufland_zu_2 AS PCK
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON PCK.mandant_id = WUP.mandant_id AND PCK.wup_id = WUP.wup_id
WHERE PCK.airline_distance > 0.00;