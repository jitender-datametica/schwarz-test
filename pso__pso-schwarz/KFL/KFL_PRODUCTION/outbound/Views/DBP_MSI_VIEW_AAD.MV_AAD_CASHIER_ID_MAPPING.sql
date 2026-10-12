CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_cashier_id_mapping (hashed_cashier_id, mandant_id, wup_id
, kassierer_nr, hash_generation_dt, hashed_cashier_bez) AS SELECT V01.hashed_cashier_id,
 V01.mandant_id,
 V02.aktuell_wup_id AS wup_id,
 V01.kassierer_nr,
 V01.hash_generation_dt,
 LEFT(V01.hashed_cashier_id, 30) AS hashed_cashier_bez
FROM kfl_production_dbp_view.v_aad_cashier_id_mapping AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;