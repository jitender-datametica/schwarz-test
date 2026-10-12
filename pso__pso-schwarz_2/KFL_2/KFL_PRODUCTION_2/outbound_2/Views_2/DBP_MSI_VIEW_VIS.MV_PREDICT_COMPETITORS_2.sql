CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_predict_competitors_2 (google_place_id, mandant_id,
competitor_name, wup_name, wup_str, wup_standort, laengengrad, breitengrad) AS SELECT google_place_id,
 mandant_id,
 competitor_name,
 kfl_production_dbp_process.transcriptc(wup_name) AS wup_name,
 kfl_production_dbp_process.transcriptc(wup_str) AS wup_str,
 wup_standort,
 laengengrad,
 breitengrad
FROM kfl_production_dbp_view.v_predict_competitors_2;