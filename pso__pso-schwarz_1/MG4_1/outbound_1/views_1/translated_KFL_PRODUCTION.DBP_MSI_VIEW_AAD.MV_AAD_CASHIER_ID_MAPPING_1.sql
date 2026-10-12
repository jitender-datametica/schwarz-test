CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_cashier_id_mapping_1 (hashed_cashier_id, mandant_id, wup_id
, kassierer_nr, hash_generation_dt, hashed_cashier_bez) AS SELECT v01.hashed_cashier_id,
 v01.mandant_id,
 v02.aktuell_wup_id AS wup_id,
 v01.kassierer_nr,
 v01.hash_generation_dt,
 LEFT(v01.hashed_cashier_id, 30) AS hashed_cashier_bez
FROM kfl_production_dbp_view.v_aad_cashier_id_mapping_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS v02 ON v01.wup_id = v02.wup_id AND v01.mandant_id = v02.mandant_id;